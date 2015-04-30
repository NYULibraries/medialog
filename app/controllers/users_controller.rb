class UsersController < ApplicationController
  before_filter :authorize_admin

  def create
    # admins only
    @u = params['user']
    @user = User.new
    @user.email = @u['email']
    @user.password = @u['password']
    @user.admin = false
    @user.save
    redirect_to root_path, notice: ('Account created for ' + @user.email)
  end

  def show
    redirect_to root_path, alert: 'Contact an admin to register'
  end

  private

  # This should probably be abstracted to ApplicationController
  # as shown by diego.greyrobot
  def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: 'Admins only!'
  end
end