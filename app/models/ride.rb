class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :user_rides
  has_many :users, through: :user_rides


    validates :vehicle, presence: true,allow_blank: false

    validates :vehicle, length:{minimum: 2}
    validates :date, presence: true,allow_blank: false, inclusion: { in: (Date.today..Date.today+5.years) }, :on=> :create
    
    validates :return_time, presence: true,allow_blank: false
    validates :leave_time, presence: true,allow_blank: false

    validates :meeting_location, presence: true,allow_blank: false

    validates :number_of_seats , presence: true,allow_blank: false,  :numericality => { :greater_than_or_equal_to => 0 }

    validates :meeting_location, length:{maximum: 70}




end
