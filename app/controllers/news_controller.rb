class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :login_required, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_required, only: [:new, :create, :edit, :update, :destroy]

  def index
    @news = News.order(created_at: :desc)
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      flash[:success] = "Hír létrehozása sikeres!"
      redirect_to(admin_path)
    else
      flash[:danger] = "Hiba történt!"
      render :new
    end 
  end

  def edit
  end

  def update
    if @news.update(news_params)
      flash[:success] = "Hír szerkesztése sikeres"
      redirect_to(admin_path)
    else
      flash[:danger] = "Hiba történt!"
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_back(fallback_location: root_url)
  end

  private
    def set_news
      @news = News.find params[:id] 
    end
    
    def news_params
      params.require(:news).permit(:title, :body, :user_id, :important)
    end
end
