class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

	def new
		@user = User.new
	end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.username}, sua inscrição foi realizada com sucesso. Bem vindo ao Alpha Blog!"
      redirect_to articles_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Usuário atualizado com sucesso"
      redirect_to articles_path(@user)
    else
      render 'edit'
    end  
  end

   def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Uusário removido com sucesso"
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)  
    end
end