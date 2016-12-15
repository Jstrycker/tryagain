class ServicesController < ApplicationController
    before_action :ensure_user_logged_in, only: [:edit,:update,:destroy,:new,:create]
    before_action :ensure_correct_user, only: [:edit,:update]
    before_action :ensure_admin, only: [:destroy]



    def new
	@service = Service.new
    end

def index
 @services =Service.all
end
    def create
	@service = service.new(service_params)
	if @service.save
	    flash[:success] = "service created"
	    redirect_to @service
	else
	    flash.now[:danger] = "Unable to create service"
	    render 'new'
	end
    end


def edit
	@service =Service.find(params[:id])
rescue
	flash[:danger] = "Unable to find service"
	redirect_to services_path


end

def show
	@ride=Ride.new
	@service=Service.find(params[:id])
    rescue
	flash[:danger] = "Unable to find church"
	redirect_to churches_path

end



def update
@service =Church.find(params[:id])
if @service.update_attributes(service_params)
else
	flash[:danger] = "update failed"
	redirect_to services_path



end
end

def destroy
	@service=Service.find(params[:id])
	@church.destroy
	flash[:success] = "service burnt to the ground"
	redirect_to service_path


end

    def service_params
	params.require(:service).permit( :start_time,
					 :finish_time,
		   		         :location, 
			 	         :day_of_week,
					 :church_id )
    end





    def ensure_user_logged_in
	unless current_user
	    flash[:warning] = 'Not logged in'
	    redirect_to login_path
	end
    end

    def ensure_correct_user
	@service=Service.find(parans[:id])
	@user=user.find(@service.church.user_id)
		unless current_user?(@user)

	redirect_to services_path
end
end
end

