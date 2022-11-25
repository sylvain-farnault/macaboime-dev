class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]


  def index
    @articles = Article.all
  end

  def show

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.season = @article.edition.season
    if @article.save
      redirect_to articles_path, notice: "\"#{@article.title}\" a bien été créé."
    else
      render :new, alerte: "Attention ça foire!"
    end
  end

  def edit

  end

  def update
    if @article.update(article_params)
      @article.update_columns(season_id: @article.edition.season.id)
      redirect_to articles_path, notice: "\"#{@article.title}\" a bien été créé."
    else
      render :new, alerte: "Attention ça foire!"
    end
  end

  def destroy
    if @article.destroy
      notice = "Article supprimé."
    else
      alert = "Impossible de supprimer cet article"
    end
    redirect_to articles_path, notice: notice, alert: alert
  end

  private

  def article_params
    params.require(:article).permit(:edition_id, :title, :content, images: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
