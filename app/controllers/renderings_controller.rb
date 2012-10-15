class RenderingsController < ApplicationController
  before_filter :signed_in_user
  
  def show
    tune = Tune.find(params[:tune_id])
    
    send_file tune.rendering_file_name, type: tune.rendering_content_type, size: tune.rendering_file_size
  end
  
  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
end
