class UsersController < ApplicationController
    before_action :ensure_user_logged_in, only: [:edit,:update]
    before_action :ensure_correct_user, only: [:edit,:update]
    before_action :ensure_admin, only: [:destroy]

    def index
	@users = User.all
    end
	def destroy
	@user=User.find(params[:id])
	@user.destroy
	flash[:success] = "User disintegrated"
	redirect_to users_path


	end
    def new
	@user = User.new
    end

    def create
	@user = User.new(user_params)
	if @user.save
	    flash[:success] = "Welcome to the site, #{@user.name}"
	    redirect_to @user
	else
	    flash.now[:danger] = "Unable to create new user"
	    render 'new'
	end
    end

    def show
	@user = User.find(params[:id])
    rescue
	flash[:danger] = "Unable to find user"
	redirect_to users_path
    end

def edit
	@user =User.find(params[:id])
end

def update
@user =User.find(params[:id])
if @user.update_attributes(params.require(:user).permit(:name, :email, :password))
flash[:success]="works";
redirect_to "/users/1"
else
flash[:danger]="fails"
end
end

    private

    def user_params
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def ensure_user_logged_in
	unless current_user
	    flash[:warning] = 'Not logged in'
	    redirect_to login_path
	end
    end

    def ensure_correct_user
	@user = User.find(params[:id])
	unless current_user?(@user)
	    flash[:danger] = "Cannot edit other user's profiles"
	    redirect_to root_path
	end
    rescue
	flash[:danger] = "Unable to find user"
	redirect_to users_path
    end

    def ensure_admin
	unless current_user.admin?
	    flash[:danger] = 'Only admins allowed to delete users'
	    redirect_to root_path
	end
    end
end
