class MainController < ApplicationController
  def home
    @url = Url.new
    @urls_ranking = Url.order(views: :desc).limit(100)
  end

  def create
    @url = Url.new(url_params)
    unless @url.save
      render nothing: true, status: 400 and return
    end
  end

  def show
    url_id = BijectiveEncodingService.decode(params[:short_code])
    @url = Url.find(url_id)

    @url.count_view!
    redirect_to @url.original and return
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
