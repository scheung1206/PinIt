class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Followed."
      redirect_to :back
    else
      flash[:error] = "Error occurred when Following."
      redirect_to :back
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    print(@friendship)
    @friendship.destroy
    flash[:notice] = "Successfully unfollowed."
    redirect_to :back
  end
end
