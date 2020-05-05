class UsersController < ApplicationController

  before_action :authenticate_user! ,except: [:top, :about]

  before_action :ensure_correct_user,{only: :edit}

  def ensure_correct_user
  	@user =User.find(params[:id])
  	if @user != current_user
  		redirect_to user_path(current_user.id)
  	end
  end

  def show
  	@user=User.find(params[:id])
  	@book=Book.new
  	@books=@user.books.all
  end

  def index
  	@user=current_user
  	@users = User.all
  	@book=Book.new
  end

  def top
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
  	@user = current_user
    if @user.update(user_params)
       flash[:notice]="successfully"
	   redirect_to user_path(@user.id)
    else
	   flash[:notice]="errors"
	   render :edit
    end
  end
  def about
  end
  private
	def user_params
	    params.require(:user).permit(:name, :introduction, :profile_image)
	end

end
