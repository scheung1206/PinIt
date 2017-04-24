class RoomsController < ApplicationController
require "opentok"
before_filter :config_opentok,:except => [:index]
  def index
    @rooms = Room.where(:public => true).order("created_at DESC")
    @new_room = Room.new
  end

def create
  session = @opentok.create_session
  params[:room][:sessionId] = session.session_id

  @new_room=Room.new(room_params)

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
