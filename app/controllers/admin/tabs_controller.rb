class Admin::TabsController < ApplicationController
  layout "admin"
  FROALA_STR = '<p data-f-id="pbf" style="text-align: center; font-size: 14px; margin-top: 30px; opacity: 0.65; font-family: sans-serif;">Powered by <a href="https://www.froala.com/wysiwyg-editor?pb=1" title="Froala Editor">Froala Editor</a></p>'

  def index
    @tabs = Tab.order(created_at: :desc)
  end

  def edit
    @tab = Tab.find(params[:id])
  end

  def update
    @tab = Tab.find(params[:id])
    @tab.text_en.gsub!(FROALA_STR,  "")
    @tab.text_ru.gsub!(FROALA_STR,  "")
    @tab.update!(tab_params)
    redirect_to admin_tabs_path
  end

  def new
    @tab = Tab.new
  end

  def create
    @tab = Tab.new(tab_params)
    @tab.text_en.gsub!(FROALA_STR,  "")
    @tab.text_ru.gsub!(FROALA_STR,  "")
    if @tab.save!
      redirect_to admin_tabs_path
    end
  end

  private

  def tab_params
    params.require(:tab).permit(:title_en, :title_ru, :text_en, :text_ru, :for_registered)
  end

end
