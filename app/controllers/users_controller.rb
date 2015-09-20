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

  def upload
    @user = User.find(params[:id])
    client = DropboxClient(ENV["DROPBOX_TOKEN"])
    client.put_file("/u#{@user.id}", params[:image],true)
  end
end
