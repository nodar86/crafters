class AdminController < ApplicationController
  before_action :login_required, :admin_required

  def admin
    @events = Event.order(:startDate)
    @users = User.order(:username)
    @news = News.order(:created_at)
  end
end
