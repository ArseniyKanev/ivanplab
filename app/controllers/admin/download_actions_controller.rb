class Admin::DownloadActionsController < ApplicationController
    layout "admin"
  
    def index
      @download_actions = DownloadAction.order(created_at: :desc)
    end  
end
  