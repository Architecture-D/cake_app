class Admin::HomeController < ApplicationController

	before_action :authenticate_admin!

  def top
  	@orders =  Order.where(created_at: Time.zone.now.all_day)
  end
end
