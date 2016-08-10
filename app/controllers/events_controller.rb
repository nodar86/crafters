class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :login_required, :only => [:index]

  def index
    @events = Event.order(startDate: :desc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "Event létrehozása sikeres!"
      redirect_to(admin_path)
    else
      flash[:danger] = "Hiba történt!"
      render :new
    end 
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = "Event szerkesztése sikeres"
      redirect_to(admin_path)
    else
      flash[:danger] = "Hiba történt!"
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_back(fallback_location: root_url)
  end

  def apply
    @event = Event.find_by_id params[:id]
    @event.users << @user
    redirect_back(fallback_location: root_url)
  end

  def resign
    @event = Event.find_by_id params[:id]
    @event.users.delete @user
    redirect_back(fallback_location: root_url)
  end

   private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :groupEvent, :maxPlayers, :playersInGroup, :startDate)
    end
end 
