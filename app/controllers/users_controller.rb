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

  def destroy
    @user = User.find(params['id'] )
    @user.is_active = false
    @user.deleted_at = Time.now
    if @user.save
      redirect_to "/admin", notice: (@user.email + "deactivated")
    else
      redirect_to "/admin",   notice: (@user.email + "not deactivated")
    end
  end

  
  def reset_password
    @user = User.find(params['id'])
  end

  def update_password
    puts(params)
    puts(@password)
    @user = User.find(params['password_request']['id'])
    @user.password = params['password_request']['password']
    @user.password_confirmation = params['password_request']['password']
    if @user.save then
      redirect_to "/admin", notice: 'password updated'
    else
      redirect_to "/admin", alert: 'password update unsuccessful'
    end
  end


  def make_admin
    @user = User.find(params['id'] )
    @user.admin = true
    if @user.save
      redirect_to "/admin", notice: (@user.email + "given admin priviledges")
    else
      redirect_to "/admin",   notice: (@user.email + "not given admin priviledges")
    end
  end


  def admin
    :authorize_admin
    @users = User.all
  end

  private

  # This should probably be abstracted to ApplicationController
  # as shown by diego.greyrobot
  def authorize_admin
    return unless current_user.admin?
    redirect_to root_path, alert: 'Admins only!'
  end
end