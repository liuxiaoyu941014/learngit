require 'active_model'
require 'json'
module Permission
  class BaseSet < ::Set
    def ==(other)
      key.to_s.to_sym == other.key.to_s.to_sym
    end
    def as_json
      self.map(&:as_json)
    end
  end

  # Collection of Definition
  class DefinitionCollection < Permission::BaseSet; end
  # Definition
  class Definition
    # Action of resource
    class Action
      def key *args
        if args.length == 0
          @key
        else
          @key = args.first.to_sym
        end
      end
      def title *args
        if args.length == 0
          @title
        else
          @title = args.first
        end
      end
      def description *args
        if args.length == 0
          @description
        else
          @description = args.first
        end
      end

      def as_json
        {
          key: key,
          title: title,
          description: description
        }
      end
      def initialize(data={})
        @key = data[:key].to_sym if data.key?(:key)
        @title = data[:title] if data.key?(:title)
        @description = data[:description] if data.key?(:description)
      end
    end
    # Collection of Action
    class ActionCollection < Permission::BaseSet; end
    # Collection of Child
    class ChildCollection < Permission::BaseSet; end
    # declarations of Definition 
    @@list = DefinitionCollection.new
    def self.list
      @@list
    end
    @@attributes = []
    def self.attributes
      @@attributes
    end

    def self.define_attribute(*attrs)
      attrs.each do |attr|
        class_eval <<-CODE
        def #{attr}(*args)
          if args.length == 0
            @#{attr}
          else
            @#{attr} = args.first#{'.to_sym' if attr == :key}
          end
        end
        CODE
        attributes << attr.to_sym
      end
    end
    
    # key # 资源标识
    # title # 显示名称
    # description # 描述
    # resource_class # Model 类名：如果不为空，就说明是跟数据库有关的资源
    # resource_belongs_to
    # resource_has_many
    # closure_tree_parent # 如果是树形资源，获得父资源的方法
    # closure_tree_children # 如果是树型资源，获得子资源恶方法
    # parent # 所属上级的权限定义
    define_attribute \
      :key,
      :title,
      :description,
      :resource_class,
      :resource_belongs_to,
      :resource_has_many,
      :closure_tree_parent,
      :closure_tree_children
    
    attributes.freeze
    
    attr_accessor :parent
    attr_reader :actions, :children, :parent_relation, :children_relations
    
    def self.config(&block)
      instance_eval(&block)
    end

    def self.permission(key, &block)
      perm = new(key)
      perm.instance_eval(&block) if block_given?
      self.list << perm
      perm
    end

    def initialize(key)
      @key = key.to_sym if key
      @actions = ActionCollection.new
      @children = ChildCollection.new
      @children_relations = {}
      self
    end

    def child(key, &block)
      perm = self.class.new(key)
      perm.parent = self
      self.children << perm
      perm.instance_eval(&block) if block_given?
      perm
    end

    def action(key, options={}, &block)
      action = Action.new(options.merge(key: key))
      action.instance_eval(&block) if block_given?
      self.actions << action
      action
    end

    def parent_relation(belongs_to_method, has_many_method)
      parent.children_relations[key] = has_many_method
      @parent_relation = belongs_to_method
    end

    def as_json
      {}.tap do |h|
        self.class.attributes.each do |attr|
          h[attr] = self.send(attr)
        end
        h[:children] = self.children.as_json
        h[:actions] = self.actions.as_json
      end
    end
  end

  class Entry
    include ActiveModel::AttributeAssignment
    attr_accessor :key
    attr_accessor :resource_id
    attr_accessor :owner
    attr_accessor :action
    attr_accessor :deny
    attr_accessor :definition

    def initialize(data={})
      self.assign_attributes(data)
    end

    def to_s
      "#{key}##{action_option}-#{action}##{resource_id}"
    end

    def action_option
      v = 0
      v |= ACTION_OPTION_DENY if deny
      v |= ACTION_OPTION_OWNER if owner
      v |= ACTION_OPTION_RES if resource_id
      v
    end

    # special chars:
    #   #: fields splitter
    #   -: option splitter
    # action options:
    #   1: deny
    #   2: owner
    #   4: specific resources, check the third field
    # examples:
    #  apps#5-destroy#1  => deny destroying app which app.id is 1
    #  apps#2-update     => allow owner updating app
    #  apps#0-create     => allow creating app
    ACTION_OPTION_DENY = 1
    ACTION_OPTION_OWNER = 2
    ACTION_OPTION_RES = 4
    def self.parse(str)
      key, action, resource_id = str.to_s.split('#', 3)
      return if key.nil? || key.strip.empty?
      if action
        action_option, action = action.split('-', 2)
        action_option = action_option.to_i
        deny = !!(action_option & ACTION_OPTION_DENY)
        owner = !!(action_option & ACTION_OPTION_OWNER)
        resource_id = nil unless action_option & ACTION_OPTION_RES
      else
        action, resource_id, owner, deny = [nil, nil, false, false]
      end
      new(key: key, action: action, resource_id: resource_id, owner: owner, deny: deny)
    end
  end

  class Path
    attr_accessor :entries
    def initialize(entries)
      self.entries = Permission::BaseSet.new(entries)
    end

    def self.parse(str)
      root_definitions = Permission::Definition.list
      found_definition = nil
      entries = []
      str.to_s.split('/').each do |part|
        entry = Permission::Entry.parse(part)
        return if entry.nil?
        found_definition = root_definitions.find { |d| d.key.to_sym == entry.key.to_sym }
        return nil if found_definition.nil?
        root_definitions = found_definition.children
        entry.definition = found_definition
        entries << entry
      end
      new(entries)
    end

    def to_s
      entries.map(&:to_s).join('/')
    end
  end
end
