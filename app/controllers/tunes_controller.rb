class TunesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, :only => [:edit, :update]
  
  def index
    @tunes = Tune.all
  end
  
  def show
    @tune = Tune.find(params[:id])
  end
  
  def new
    @tune = @current_user.tunes.new 
  end
  
  def edit
  end
  
  def update
    if @tune.update_attributes(params[:tune])
      flash[:success] = "Profile updated"
    
      redirect_to @tune
    else
      render 'edit'
    end
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
  
  private
    def correct_user
      @tune = Tune.find(params[:id])
      @user = @tune.user
      redirect_to(root_path) unless current_user?(@user)
    end
end
