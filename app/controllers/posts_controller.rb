class PostsController < ApplicationController
  layout 'frontend'
  def index
    @articles = Article.where(published: "true").order("title").page(params[:page]).per(5)
  end
  # GET /articles/1
  # GET /articles/1.json
  def show
        @article = Article.friendly.find(params[:id])
        
        @comments = @article.comments.order("id desc")

        @comment = Comment.new
  end
  # GET /articles/new
  def new
    @article = Article.new
  end
  def chart
    @visits = Visit.all
  end
  def visits_by_day
   render json: Visit.group_by_day(:visited_at, format: "%B %d, %Y").count
  end
  def word
    @h1_text = 'John Dugan'
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"word.docx\"" }
    end
  end
end
