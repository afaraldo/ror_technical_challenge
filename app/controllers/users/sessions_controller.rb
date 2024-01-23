class Users::SessionsController < Devise::SessionsController
  def create
    super do |user|
      if user
        token = JwtService.encode({ user_id: user.id })
        response.set_header('Authorization', token)
      end
    end
  end
end
