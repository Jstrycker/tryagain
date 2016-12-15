class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :user_rides
  has_many :users, through: :user_rides
validates :service_id, presence: true
validates :user_id, presence: true	
    validates :vehicle, presence: true,allow_blank: false
    validates :vehicle, length:{minimum: 2}
    validates :date, presence: true,allow_blank: false, inclusion: { in: (Date.today+1.day..Date.today+5.years) }, :on=> :create
     validates :date, presence: true,allow_blank: false   
    validates :return_time, presence: true,allow_blank: false 
    validates :leave_time, presence: true,allow_blank: false
    validates :meeting_location, presence: true,allow_blank: false

    validates :number_of_seats , presence: true,allow_blank:false , :numericality => {:allow_nil=> true, :greater_than_or_equal_to => :seats_available , :only_integer => true}
 validates :seats_available , presence: true, allow_blank:false,:numericality => {:allow_nil=>false, :greater_than_or_equal_to => 0 , :only_integer=>true}
  

    validates :meeting_location, length:{maximum: 70}




end
