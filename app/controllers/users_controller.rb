class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:index, :show, :edit, :destroy, :update]
  before_filter :correct_user_or_admin,   :only => [:edit, :update]
  before_filter :admin_user,     :only => :destroy
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(:page => params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to Dunekacke, you will be activated soon!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
    
      if current_user.admin?
        redirect_to users_url
      else
        sign_in @user
        redirect_to @user
      end
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if current_user?(@user) 
      redirect_to(root_path) 
    else    
      @user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
  end
  
  private    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def correct_user_or_admin
      @user = User.find(params[:id])
      
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
