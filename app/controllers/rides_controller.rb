

class RidesController < ApplicationController
helper_method :clain

    before_action :ensure_user_logged_in, only: [:edit,:update,:destroy,:new,:create, :attend, :show, :index]
    before_action :ensure_correct_user, only: [:edit,:update]
    before_action :ensure_admin, only: [:destroy]
def clain
@ride= Ride.find(params[:id])
@ride.seats_left--
@ride.save
end
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
	@ride = Ride.new(ride_params)
	
	@ride.user=current_user
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
end

def edit
	@ride=Ride.find(params[:id])
	@user= current_user
end

def update

	@user =current_user
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
@user=current_user
end
def ride_params

params.permit(:user,:date,:leave_time,:return_time,:number_of_seats,:seats_available,:meeting_location,:vehicle,:service)

end

def destroy
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

end
