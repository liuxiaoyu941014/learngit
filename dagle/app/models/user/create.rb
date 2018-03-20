class User
  Create =
    lambda do |attributes, current_user = nil|
      flag = false
      user = User.new(attributes)
      mobile_phone = attributes[:mobile_phone]

      if current_user && user.roles.any?
        # 超级管理员只能通过程序创建user.add_role('super_admin'), 任何用户都无法创建
        user.roles.delete(Role.find_by_name('super_admin'))
        # 只有超级管理员才能创建管理员
        unless current_user.has_role?(:super_admin)
          user.roles.delete(Role.find_by_name('admin'))
        end
      end
      if mobile_phone.present?
        mobile = User::Mobile.find_or_initialize_by(phone_number: mobile_phone)
        if mobile.new_record?
          user.password ||= Devise.friendly_token[0,20]
          user.mobile = mobile
          flag = user.save
        else
          user.errors.add :mobile_phone, '已经存在'
        end
      else
        flag = false
        user.errors.add :mobile_phone, '手机号必须填写'
      end
      [flag, user]
    end
end
