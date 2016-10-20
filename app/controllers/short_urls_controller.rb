class ShortUrlsController < ApplicationController
  def create
    render json: ShortUrl.create(short_url_params)
  end

  def show
  end

  protected

  def short_url_params
    params.permit(:url)
  end
end
