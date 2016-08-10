class StaticPagesController < ApplicationController
  before_action :login_required, :only => [:dynmap, :dynmap_inside]

  def index
    require 'minecraft-query'
    begin
      @query = Query::simpleQuery('localhost', 25565)
      if @query.is_a?(Hash)
        @query[:online] = true
      else
        @query = {:online => false}
      end
    end
    @news = News.where(important: true).order(created_at: :desc).first
  end

  def rules
  end

  def help
  end

  def donate
  end

  def dynmap
  end

  def dynmap_inside
  end

  def privacy_policy
  end

  def login
  end
end
