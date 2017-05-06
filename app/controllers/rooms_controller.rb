class RoomsController < ApplicationController
require "opentok"
before_filter :config_opentok,:except => [:index]
before_action :authenticate_user!
  def index
    @rooms = Room.all.order("created_at DESC")
    @user = current_user
    @new_room = Room.new
  end

def create
  session = @opentok.create_session
  params[:room][:sessionId] = session.session_id

  @new_room=Room.new(room_params)
  @new_room.user_id = current_user.id
  respond_to do |format|
    if @new_room.save
      format.html { redirect_to @new_room}
    else
      format.html { render :controller => ‘rooms’, :action => “index” }
    end
  end
end

def show
  @room = Room.find(params[:id])
  @user = User.find(@room.user_id)
  @tok_token = @opentok.generate_token @room.sessionId
end

  private
  def config_opentok
    if @opentok.nil?
     @opentok = OpenTok::OpenTok.new 45827462, "c38b60ee4dbba8a3068d0587175168e36a0f882b"
    end
  end

  	private
    def room_params
    	params.require(:room).permit(:name, :public, :sessionId)
	end
end
