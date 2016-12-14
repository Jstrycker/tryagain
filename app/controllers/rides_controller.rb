

class RidesController < ApplicationController
    before_action :ensure_user_logged_in, only: [:create]
    before_action :ensure_correct_user, only: [:edit, :update, :destroy]

    def index
	order_param = (params[:order] || :Date).to_sym
	ordering = case order_param
		   when :Date
		       :date
		   when :Service
		       :service_id
		   end
	@rides = Ride.order(ordering)
    end

    def create
	@user=current_user
	@ride = Ride.new(@user.id,@user.church.id,ride_params)
	if @ride.save
	    flash[:success] = "Good job with ride, #{current_user.name}"
	    redirect_to @ride
	else
	    flash.now[:danger] = "Unable to create new ride"
	    render 'new'
	end
end
 
def show
@ride= Ride.find(params[:id])
    rescue
	flash[:danger] = "Unable to find user"
	redirect_to users_path


end

def edit
	@ride=Ride.find(params[:id])
	@user= current_user
end

def update

	@user =User.find(params[:id])
@ride =Rides.find(params[:id])
if @ride.update_attributes(ride_params)
flash[:success]="works";
redirect_to "/users/1"
else
flash[:danger]="fails"
end
end

def new
@ride=Ride.new
end


    private

    def ensure_user_logged_in
	unless current_user
	    flash[:warning] = 'Not logged in'
	    redirect_to login_path
	end
    end

    def ensure_correct_user
	@user = User.find(params[Ride.find(params[:id]).user_id])
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

def ride_params

params.require("date","leave_time","return_time","number_of_seats","seats_available","meeting_location","vehicle")

end

def destroy
end

end
