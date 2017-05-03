class UsersController < ApplicationController
   before_action :correct_user, only: [:edit, :update]
  def index
    @users = User.all
  end

  def show
    # params[:id] comes from the URL: /users/:id
    @user = User.find(params[:id])
    @users = User.all
    @pins = @user.pins.all.order("created_at DESC")
    @albums = Album.where(user_id: @user.id)
    @album = Album.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @users = User.all
    if @user.update_attributes(user_params)
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  private

    def correct_user
      # .to_i converts values to integers here because params[:id] is a string
      # Without this current_user.id and params[:id] would never match
      if current_user.id != params[:id].to_i
        redirect_to root_url
      end
    end

    def user_params
      params.require(:user).permit(:Bio, :FirstName, :LastName,:avatar)
    end
end
