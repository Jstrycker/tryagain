class ChurchesController < ApplicationController
    before_action :ensure_user_logged_in, only: [:destroy, :new,:create, :attend]
    before_action :ensure_correct_user, only: []
    before_action :ensure_admin, only: [:destroy]



    def new
	@church = Church.new
	@church.services.build
    end

def index
 @churches =Church.all
end
    def create
	@church = Church.new(church_params)
	@church.user = current_user
	if @church.save
	    flash[:success] = "Church created"
	    redirect_to @church
	else
	    flash.now[:danger] = "Unable to create church"
	    render 'new'
	end
    end


def attend
	@church=Church.find(params[:id])
@user=current_user
@church.users<<@user.id
end


def edit
	@church =Church.find(params[:id])
rescue
	flash[:danger] = "Unable to find church"
	redirect_to churches_path


end

def show

	@user=current_user
	@church=Church.find(params[:id])
	@users=@church.users
	@services=@church.services
    rescue
	flash[:danger] = "Unable to find church"
	redirect_to churches_path

end

def update
@church =Church.find(params[:id])
if @church.update_attributes(church_params)
flash[:success]="works";
redirect_to @church
else
flash[:danger]="fails"
end
end

def destroy
	@church=Church.find(params[:id])
	@church.destroy
	flash[:success] = "Church burnt to the ground"
	redirect_to churches_path


end

    def church_params
	params.require(:church).permit(:name,
				       :web_site,
				       :description,
				       :picture,
				       services_attributes: [ :start_time,
							      :finish_time,
							      :location, 
							       :day_of_week] )
    end





    def ensure_user_logged_in
	unless current_user
	    flash[:warning] = 'Not logged in'
	    redirect_to login_path
	end
    end

    def ensure_correct_user
	@church=Church.find(parans[:id])
	@user=user.find(@church.user_id)
	unless current_user?(@user)
	    flash[:danger] = "Cannot edit other churches's profiles"
	    redirect_to churches_path
	end
    rescue
	flash[:danger] = "Unable to find user"
	redirect_to root_path
    end

    def ensure_admin
	unless current_user.admin?
	    flash[:danger] = 'Only admins allowed to delete churches'
	    redirect_to churches_path
	end
    end
end
