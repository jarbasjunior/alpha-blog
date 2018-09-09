class UsersController < ApplicationController

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

  private
    def set_user
      @user = user.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:username, :email, :password)  
    end
end