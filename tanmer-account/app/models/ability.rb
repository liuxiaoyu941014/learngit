class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    permissions = user.permissions.where(app: Doorkeeper::Application.main)
    can do |action, subject_class, subject|
      action_arr = action ? Array(action) : [nil]
      action_arr.any?{ |a| (subject_class == Array ? subject : Array(subject_class)).any? { |s| _check_permission(permissions, a, s, subject) } }
    end
  end

  def _check_permission(permissions, action, subject_class, subject)
    if subject_class == String
      subject_class = subject
      subject = nil
    end
    permissions.any? do |permission|
      (action.nil? || permission.action == action.to_s) &&
        permission.subject_class == subject_class.to_s &&
        (subject.nil? || permission.subject_id.nil? || permission.subject_id == subject.id)
    end
  end
end
