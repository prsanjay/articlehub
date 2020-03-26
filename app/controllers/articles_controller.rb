class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  SEARCH_STRING = 'title_or_action_text_rich_text_body_or_user_email_cont'.freeze

  def index
    result =  if params[:category].present?
                Article.tagged_with(params[:category], any: true)
              elsif params[:search].present?
                Article.ransack(SEARCH_STRING => params[:search]).result
              elsif params[:my].present?
                authenticate_user! if current_user.blank?
                current_user.articles
              else
                Article.all
              end
    @articles = result.order(created_at: :desc).page params[:page]
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article), notice: I18n.t('article.create')
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
      redirect_to article_path(@article), notice: I18n.t('article.update')
    else
      render :edit
    end
  end

  def destroy
    article.destroy
    redirect_to articles_path, notice: I18n.t('article.destroy')
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :category_list, :status, :user_id)
  end

  def article
    @article ||= Article.find(params[:id])
  end
end
