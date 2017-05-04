class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_album, only: [:show,:update]

  def new
    @user = current_user
    @album = Album.new
  end

  def edit
    @user = current_user
    @album = Album.find(params[:id])
  end

  def update
		if @album.update(album_params)
			redirect_to user_album_path, notice: "Album was updated"
		else
			render 'edit'
		end
	end

  def show
    @albumPins = AlbumPin.where(album_id: @album.id)
    @pins = Array.new
    @albumPins.each do |albumpin|
      @pins.append(Pin.find(albumpin.pin_id))
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @album = Album.find(params[:id])
    if (@album.destroy)
    redirect_to @user, notice: "Album was successfuly deleted."
    end
  end

  def remove
    @albumPin = AlbumPin.find(params[:id])
    if (@albumPin.destroy)
    redirect_to :back, notice: "Pin was successfuly removed from the album."
    end
  end

  def create
    @user = current_user
    @album = Album.new(album_params)
    @album.user_id = current_user.id
    respond_to do |format|
      if (@album.save && @album.title != "")
        format.html { redirect_to @user, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { redirect_to @user,notice: 'Please enter Album title.'}
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album= Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title,:private)
    end
end
