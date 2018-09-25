class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :update, :destroy] 
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Artigo criado com sucesso!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def new
    @article = Article.new
  end

  def edit 
  end

  def show
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Artigo atualizado com sucesso!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Artigo removido com sucesso!"
    redirect_to articles_path
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)  
    end

    def require_same_user
      if @article.user != current_user
        flash[:danger] = "Você não tem permissão para editar ou remover este artigo!"
        redirect_to root_path
      end
    end
end 