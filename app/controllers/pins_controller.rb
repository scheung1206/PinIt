class PinsController < ApplicationController
	#before_action :authenticate_user!, except: [:index, :show]
	before_action :find_pin, only: [:show,:edit,:update,:destroy,:upvote]
	before_action :authenticate_user!

	def index
		@pins =Pin.all.order("created_at DESC")
	end
	def new
		@pin = current_user.pins.build
	end
	def show
		@pin = Pin.find params[:id]
		@comments = @pin.comments.all
		@comment = Comment.new
		@effect = 0
	end
	def create
		@pin = current_user.pins.build(pin_params)

		if @pin.save
			redirect_to @pin, notice: "Created new Pin"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @pin.update(pin_params)
			redirect_to @pin, notice: "Pin was updated"
		else
			render 'edit'
		end
	end

	def destroy
		#@pin = Pin.find(params[:id])
		@pin.destroy
		redirect_to root_path
	end

	def upvote
		@pin.upvote_by current_user
		redirect_to :back
	end

	def search
		if params[:search].present?
			@pins = Pin.search(params[:search])
		else
			@pins = Pin.all
		end
	end

	def grey
		@pin = Pin.find params[:id]
		@comments = @pin.comments.all
		@comment = Comment.new
		@effect = 1
	end

	def blur
		@pin = Pin.find params[:id]
		@comments = @pin.comments.all
		@comment = Comment.new
		@effect = 2
	end

	def contrast
		@pin = Pin.find params[:id]
		@comments = @pin.comments.all
		@comment = Comment.new
		@effect = 3
	end

	def following
    @friends = current_user.friendships.all
    friendsPins = Array.new
    @friends.each do |friend|
      afriend = User.find(friend.friend_id)
      afriend.pins.all.each do |pin|
        friendsPins.push(pin)
      end
    end
    @pins = friendsPins.sort_by {|pin| pin.created_at }.reverse
  end

	def mine
		@pins = current_user.pins.all.order("created_at DESC")
	end
	private

	def pin_params
		params.require(:pin).permit(:title,:description,:image, :ytlink)
	end
	def find_pin
		@pin = Pin.find(params[:id])
	end
end
