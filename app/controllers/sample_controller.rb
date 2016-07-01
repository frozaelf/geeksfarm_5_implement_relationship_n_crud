class SampleController < ApplicationController
  layout 'frontend'
  def index
  end

  def new
  end

  def gmaps
  end

  def ckeditor
  end

  def paperclip
  end

  def growl
  end

  def recaptcha
  end

  def friendly_id
  end

  def kaminari
  end

  def prawn
  end

  def datatables
    respond_to do |format|
      format.html
      format.json { render json: ArticleDatatable.new(view_context) }
    end
  end

  def redis
    
  end

  def chartkick
    @visits = Visit.all
  end
  
  def visits_by_day
   render json: Visit.group_by_day(:visited_at, format: "%B %d, %Y").count
  end
end
