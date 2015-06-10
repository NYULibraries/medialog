class UsersController < ApplicationController
  

  def create
    :authorize_admin
    # admins only
    @u = params['user']
    @user = User.new
    @user.email = @u['email']
    @user.password = @u['password']
    @user.admin = false
    @user.save
    redirect_to root_path, notice: ('Account created for ' + @user.email)
  end

  def reset_password
    @user = User.where(:id => current_user.id)[0]
  end

  def update_password
    @password = params['password_request']['password']
    @user = User.where(:id => current_user.id)[0]
    @user.password = @password
    @user.password_confirmation = @password
    if @user.save then
      redirect_to root_path, notice: 'password updated'
    else
      redirect_to root_path, alert: 'password update unsuccessful'
    end
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