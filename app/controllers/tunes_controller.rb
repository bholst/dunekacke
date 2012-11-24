class TunesController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @tunes = Tune.all
  end
  
  def show
    @tune = Tune.find(params[:id])
  end
end
