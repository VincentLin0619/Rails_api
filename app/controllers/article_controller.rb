class ArticleController < ApplicationController
  def index
    article = Article.all
    render json: serializer.new(article), status: :ok
  end

  def show
  end

  def serializer
    ArticleSerializer
  end
end
