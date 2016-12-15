FactoryGirl.define do
    factory :user do
	sequence(:name) { |i| "User #{i}" }
	sequence(:email) { |i| "user.#{i}@example.com" }
	password 'password'
	password_confirmation 'password'

	factory :admin do
	    admin true
	end
    end

    factory :church do
	transient { num_services 1 }
	sequence(:name) { |i| "calvinist#{i}" }
        picture "nothing"
	user_id 1
        web_site   "web_site"
        description    "description"
	after(:create) do |church, evaluator|
	    create_list(:service, evaluator.num_services, church: church)
	end
    end

    factory :service do
	church
	transient { num_rides 1 }

        church_id 1
        day_of_week 1
        start_time "10:00:00"
        finish_time "11:00:00"
        location	"Your Bed"
   
	after(:create) do |service, evaluator|
	    create_list(:ride, evaluator.num_rides, service: service)
	end
    end

    factory :ride do
	transient { num_riders 1 }
	service_id 1
	user_id 1
    	date     "1/1/2018"
    	leave_time     "10:00:00"
    	return_time    "11:00:00"
    	number_of_seats 6
        seats_available 5
        meeting_location "parking lot"
        vehicle  "THATONEDUDE'SBUS" 
	after(:create) do |ride, evaluator|
	    ride.users = create_list(:user, evaluator.num_riders)
	end
    end

    factory :user_ride do
    user_id 1
    ride_id 1
    end
end
