class TunesController < ApplicationController
  def index
    @tunes = Tune.all
  end
  
  def show
    @tune = Tune.find(params[:id])
  end
end
