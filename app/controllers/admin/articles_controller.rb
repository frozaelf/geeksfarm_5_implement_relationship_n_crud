class Admin::ArticlesController < ApplicationController
  layout 'backend', only: [:show, :edit, :index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :check_current_user
  # GET /articles
  # GET /articles.json
  def index
    #@articles = Article.order("title").page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.json { render json: ArticleDatatable.new(view_context) }
    end
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
  def test_api    
    #debugger
        
    request_uri = 'http://0.0.0.0:3000/api/v1/bycycles'
    url = 'http://0.0.0.0:3000/api/v1/bycycles'
    response = RestClient.get(request_uri)
    @show = JSON.parse(response)    
    @bycycles = @show["bycycles"]                     
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
    redirect_to admin_articles_url, notice: "Articles imported."
  end
    
  def export_csv    
      @articles = Article.all.where(slug:params[:id])
      @comments = @articles.first.comments.order("comments.id desc")
      @comment = Comment.new
      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = "attachment; filename=\"Article\""
          headers['Content-Type'] ||= 'text/csv'
        end
      end      
  end  
  def import_csv
    Article.import_csv(params[:file])
    redirect_to admin_articles_url, notice: "Articles imported."
  end
  def pdf
      # Creates a new PDF document
      pdf = Prawn::Document.new
      pdf.text "My Beautiful Background."
      
      filename = "#{Rails.root}/app/assets/images/saber.jpg"
      # Prawn supports both png and jpg images
      pdf.image filename, :width => 150
      
      # Example 2 background image
      pdf.start_new_page
      
      # Record the original y value (cause y=0 is the bottom of the page)
      y_position = pdf.cursor
      pdf.text "The image will be above."
      # Put the image with absolute positioning
      pdf.image filename, :at => [50, y_position]
      # Write on top of the image
      pdf.text "The image will be below."
      
      # Example 3 scaled images
      pdf.start_new_page
      pdf.text "Scale by setting only the width"
      pdf.image filename, :width => 150
      pdf.move_down 20
      pdf.text "Scale by setting only the height"
      pdf.image filename, :height => 100
      pdf.move_down 20
      pdf.text "Stretch to fit the width and height provided"
      pdf.image filename, :width => 500, :height => 100
      
      send_data pdf.render, :filename => "x.pdf", :type => "application/pdf", :disposition => 'inline'
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
        format.html { redirect_to [:admin, @article], notice: 'Article was successfully created.' }
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
        format.html { redirect_to [:admin, @article], notice: 'Article was successfully updated.' }
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
      @article = Article.friendly.find(params[:id])  
      @comment = Comment.find_by_article_id(params[:id]) 
      if @article.destroy  
          flash[:notice] = "Success Delete a Records"  
          redirect_to action: 'index'
        else  
          flash[:error] = "fails delete a records"  
          redirect_to action: 'index'  
      end  
  end
  def delete_selected
    #Article.where(:id => params[:id]).destroy_all
    if params[:id].blank?
      render js: "
      $.notify({
                // options
                message: 'Selected data not found'
              },{
                // settings
                type: 'danger', 
                delay: 1000
              });
    "    
    else
    Article.where(:id => params[:id]).destroy_all 
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
