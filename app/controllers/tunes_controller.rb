class TunesController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @tunes = Tune.all
  end
  
  def show
    @tune = Tune.find(params[:id])
  end
  
  def new
    @tune = @current_user.tunes.new 
  end
  
  def create
    @tune = current_user.tunes.build(:content => params[:tune][:content])
    if @tune.save
      flash[:success] = "Tune successfully added!"
      redirect_to @tune
    else
      render 'new'
    end
  end
end
