module SimpleNavigation
  module Renderer
    class Bootstrap3 < SimpleNavigation::Renderer::Base
      module ItemContainerConcern
        # attr_accessor :fa_icon
      end
      SimpleNavigation::ItemContainer.send :include, ItemContainerConcern

      def render(item_container)
        if skip_if_empty? && item_container.empty?
          ''
        else
          content = list_content(item_container)
          dom_attributes = item_container.dom_attributes.dup.tap do |attrs|
            if item_container.level > 1
              if attrs[:class]
                attrs[:class] << ' sub-menu'
              else
                attrs[:class] = 'sub-menu'
              end
            end
          end
          content_tag(:ul, content, dom_attributes)
        end
      end

      private

      def list_content(item_container)
        item_container.items.map { |item|
          li_options = item.html_options.except(:link)
          if item.sub_navigation
            if li_options[:class]
              li_options[:class] << ' has-sub'
            else
              li_options[:class] = 'has-sub'
            end
          end
          li_content = tag_for(item)
          if include_sub_navigation?(item)
            li_content << render_sub_navigation_for(item)
          end
          content_tag(:li, li_content, li_options)
        }.join
      end

      def tag_for(item)
        # binding.pry
        text_html = "".tap do |html|
          html << content_tag(:b, '', class: 'caret pull-right') if item.sub_navigation
          html << content_tag(:i, '', class: icon_class_for(item))
          html << content_tag(:span, item.name)
        end.html_safe
        if suppress_link?(item)
          content_tag('span', text_html, link_options_for(item).except(:method))
        else
          link_to(text_html, item.url, options_for(item))
        end
      end

      private

      def icon_class_for(item)
        options = item.send(:options)
        return "fa fa-#{options[:fa_icon]}" if options[:fa_icon]
      end

    end
  end
end
