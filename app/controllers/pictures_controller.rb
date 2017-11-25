class PicturesController < ApplicationController

  def create
    @picture = Picture.new(image_params)
    if @picture.save
      # byebug
      respond_to do |format|
        format.json { render :json => {url: @picture.image, picture_id: @picture.id } }
      end
    end
  end

  def destroy
    picture = Picture.find(params[:id])
    picture.destroy
    respond_to do |format|
      format.json { render json: {status: :ok } }
    end
  end

  def image_params
    params.require(:picture).permit(:image)
  end
  
end