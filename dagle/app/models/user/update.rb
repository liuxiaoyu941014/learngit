class User
  Update =
    lambda do |user_or_id, attributes, current_user = nil|
      attributes = attributes.symbolize_keys
      flag = true
      user = user_or_id.is_a?(User) ? user_or_id : User.find(user_or_id)
      mobile_phone = attributes[:mobile_phone]

      if current_user
        # 如果不是管理员，或者是在修改自己的信息，就不允许修改角色
        if !current_user.super_admin_or_admin? || current_user.id == user.id
          attributes.delete(:role_ids)
        # 否者，就是管理员正在修改他人的信息
        else
          role_ids = Array(attributes[:role_ids]).select{|id| id.present? }.map(&:to_i)
          super_admin_id = Role.find_by(name: "super_admin").id
          admin_id = Role.find_by(name: "admin").id
          # 永远不允许添加超级管理员
          role_ids.delete(super_admin_id)
          # 只有超级管理员能添加普通管理员
          role_ids.delete(admin_id) unless current_user.has_role?("super_admin")
          attributes[:role_ids] = role_ids
        end
      end

      if mobile_phone
        mobile = user.mobile || user.build_mobile
        mobile.phone_number = mobile_phone
        flag = mobile.save
        user.errors.add :mobile_phone, mobile.errors.full_messages.join(', ') unless flag
      end

      unless attributes[:password].present?
        attributes.delete(:password)
        attributes.delete(:password_confirmation)
      end

      user.assign_attributes attributes if flag

      [flag && user.save, user]
    end
end
