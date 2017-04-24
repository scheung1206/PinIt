class ChatController < ApplicationController
  def home
    session[:conversations] ||= []

    @friends = current_user.friendships.all
    friendsUser = Array.new
    @friends.each do |friend|
      friendsUser.push(User.find(friend.friend_id))
    end
    @users = friendsUser
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end
end
