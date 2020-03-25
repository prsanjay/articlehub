module ArticlesHelper

  def article_statuses
    Article.statuses.collect{|k,v| [k.humanize, k]}
  end
end
