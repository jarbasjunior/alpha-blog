class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[index show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Categoria \"#{@category.name}\" criada com sucesso!"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = 'Categoria atualizada com sucesso!'
      redirect_to categories_path(@category)
    else
      render 'edit'
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 3)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in?
      flash[:danger] = 'Você deve realizar o login e ser admin para executar esta ação!'
      redirect_to categories_path
    elsif logged_in? && !current_user.admin?
      flash[:danger] = 'Apenas usuários com perfil de administrador podem executar esta ação!'
      redirect_to categories_path
    end
  end
end
