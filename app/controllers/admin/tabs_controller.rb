class Admin::TabsController < ApplicationController
  layout "admin"

  def index
    @tabs = Tab.order(created_at: :desc)
  end

  def edit
    @tab = Tab.find(params[:id])
  end

  def update
    @tab = Tab.find(params[:id])
    @tab.update_attributes!(tab_params)
    redirect_to admin_tabs_path
  end

  def new
    @tab = Tab.new
  end

  def create
    @tab = Tab.new(tab_params)
    if @tab.save!
      redirect_to admin_tabs_path
    end
  end

  private

  def tab_params
    params.require(:tab).permit(:title_en, :title_ru, :text_en, :text_ru, :for_registered)
  end

end
