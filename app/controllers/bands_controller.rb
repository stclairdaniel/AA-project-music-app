class BandsController < ApplicationController
  before_action :require_login

  def index
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:notices] = ["Band saved"]
      redirect_to band_url(@band)
    else
      flash.now[:errors] = [@band.errors.full_messages]
      render :new
    end
  end

  def show
    @band = Band.find_by(id: params[:id])
    if @band
      render :show
    else
      flash[:errors] = ["Couldn't find the band you were looking for"]
      redirect_to bands_url
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    @band.update(band_params)
    if @band.save
      flash[:notices] = ["Band saved"]
      redirect_to band_url(@band)
    else
      flash.now[:errors] = [@band.errors.full_messages]
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

  def require_login
    unless logged_in?
      flash[:errors] = ["Must be logged in to access that content."]
      redirect_to new_session_url
    end
  end
end
