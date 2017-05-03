class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_album, only: [:show]

  def new
    @album = Album.new
  end

  def show
    @pins = Pin.where(album_id: @album.id)
  end

  def create
    @user = current_user
    @album = Album.new(album_params)
    @album.user_id = current_user.id
    respond_to do |format|
      if @album.save
        format.html { redirect_to @user, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
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
      params.require(:album).permit(:title)
    end
end