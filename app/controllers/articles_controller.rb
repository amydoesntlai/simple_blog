class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json

  before_filter :load_article
  before_filter :uppercase, :only => :index
  around_filter :handle_errors

  def index
    puts params
    if params[:order_by]
      @articles = Article.order_by(params[:order_by]).each { |article| article.title.upcase! }
    else
      @articles = Article.limit(params[:limit]).each { |article| article.title.upcase! }
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article  = Article.includes(:comments).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
  def load_article
    @article = Article.find(params[:id]) if params[:id]
  end

  def handle_errors
    begin
      yield
    rescue
      if params[:action] == 'index'
        render :text => "We apologize but this broke"
      else
        flash[:notice] = "We apologize but this broke"
        redirect_to articles_path
      end
    end
  end

  def uppercase
    @articles = Article.all.each { |article| article.title.upcase! }
  end

end
