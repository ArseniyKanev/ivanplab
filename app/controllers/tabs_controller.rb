class TabsController < ApplicationController

  def show
    @tab = Tab.find_by_slug(params[:id]) || Tab.first
    if @tab.for_registered && !user_signed_in?
      flash[:notice] = I18n.t 'only_registered'
      redirect_to :new_user_registration
    end
  end

end
