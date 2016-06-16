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
end
