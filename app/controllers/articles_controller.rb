class ArticlesController < ApplicationController
  layout 'backend'
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :check_current_user
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order("title").page(params[:page]).per(5)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show         
        @article = Article.friendly.find(params[:id])

        @comments = @article.comments.order("id desc")

        @comment = Comment.new
      respond_to do |format|
        format.html
        format.xlsx{response.headers['Content-Disposition'] = 'attachment; filename="all_articles.xlsx"'}
      end
  end
  
  def export
    
        @articles = Article.all.where(slug:params[:id])
        @comments = @articles.first.comments.order("comments.id desc")
        @comment = Comment.new
        
      respond_to do |format|
        format.html
        format.xlsx{response.headers['Content-Disposition'] = 'attachment; filename="all_articles.xlsx"'}
      end
  end
  
  def import
    Article.import(params[:file])
    redirect_to articles_url, notice: "Articles imported."
  end
  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end
  
  def download
      
  end
  
  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :image, :published)
    end
end
