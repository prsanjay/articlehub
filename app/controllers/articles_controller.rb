class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    # Need to add searching
    # Need to add pagination
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article), notice: 'Article Created Successfully'
    else
      render :new
    end
  end

  def show
    article
  end

  def edit
    article
  end

  def update
    if article.update(article_params)
      redirect_to article_path(@article), notice: 'Article Updated Successfully'
    else
      render :edit
    end
  end

  def destroy
    article.destroy
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :category_list, :status, :user_id)
  end

  def article
    @article ||= Article.find(params[:id])
  end
end
