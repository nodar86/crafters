class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]
  before_action :login_required, :only => [:new]

  def index
    @donations = Donation.all
    @donation_sum = 0
    Donation.where('extract(month from updated_at) = ?', Date.today.month).each do |donation|
      @donation_sum += donation.amount
    end   
    @donation_goal = 7000
  end

  def show
  end

  def new
    @donation = Donation.new
  end

  def edit
  end

  def create
    @donation = Donation.new
    if @donation.save
      flash[:success] = "Adomány sikeresen mentve"
      redirect_back(fallback_location: root_url)
    else 
      render :new
    end
  end

  def update
    if @donation.update(donation_params)
      flash[:success] = "Sikeresen frissítve"
      redirect_to @donation
    else
      render :edit  
    end
  end

  def destroy
    @donation.destroy
    flash[:success] = "Adomány törölve"
    redirect_to donations_url
  end

  private
    def set_donation
      @donation = Donation.find(params[:id])
    end

    def donation_params
      params.require(:donation).permit(:amount, :user_id)
    end
end
