class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def index
  	@user = User.find(params[:id])
  	@projects = @user.projects
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	permitted = params.require(:user).permit(:name, :email, :bio, :skills)
  	@user = User.find(params[:id])
  	@user.update!(permitted)
  end

end
