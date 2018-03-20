class User
  Destroy =
    lambda do |user_or_id, user: nil|
      user = user_or_id.is_a?(User) ? user_or_id : User.find(user_or_id)
      [user.destroy, user]
    end
end