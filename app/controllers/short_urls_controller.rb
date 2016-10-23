class ShortUrlsController < ApplicationController
  protect_from_forgery except: :create

  def create
    short_url = ShortUrl.create(short_url_params)
    if short_url.valid?
      render json: short_url
    else
      render status: 422, plain: short_url.errors.full_messages.to_sentence
    end
  end

  def show
    redirect_to ShortUrl.find_by_code!(params[:code]).url
  end

  protected

  def short_url_params
    params.permit(:url)
  end
end
