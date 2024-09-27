class Admin::DownloadActionsController < ApplicationController
    layout "admin"
  
    def index
      @download_actions = DownloadAction.order(created_at: :desc)
    end

    def destroy
      DownloadAction.find(params[:id]).destroy
      redirect_to admin_download_actions_path
    end
end
  