class Role < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  has_and_belongs_to_many :users, :join_table => 'roles_users'
  has_and_belongs_to_many :permissions, join_table: 'roles_permissions'
  accepts_nested_attributes_for :permissions

  ADMIN_ID = 1

  def admin?
    id == ADMIN_ID
  end

  def can_destroy?
    id != ADMIN_ID
  end

  def can_update?
    id != ADMIN_ID
  end

  def self.sync_admin_permissions!
    role = find(ADMIN_ID)
    Permission.all.each do |perm|
      unless role.permissions.exists?(id: perm.id)
        role.permissions << perm
      end
    end
  end
end
