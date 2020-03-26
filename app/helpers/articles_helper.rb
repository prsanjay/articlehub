module ArticlesHelper

  def article_statuses
    Article.statuses.collect{|k,v| [k.humanize, k]}
  end

  def category_cloud(article)
    article.category_list.collect do |category|
      link_to category, articles_url(category: category), class: 'badge badge-pill badge-primary ml-1'
    end.join.html_safe
  end
end
