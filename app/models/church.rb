class Church < ActiveRecord::Base
  belongs_to :user, inverse_of: :church_managed
  has_many :services, inverse_of: :church
  has_many :users, inverse_of: :church

  accepts_nested_attributes_for :services
    validates :user_id, presence: true
    validates :name, presence: true,allow_blank: false
    validates :name, length:{minimum: 2}
    validates :name, length:{maximum: 30}
    validates :name, uniqueness: true, on: :create
    validates :picture, presence: true,allow_blank: false

    validates :web_site, presence:true,allow_blank: false

    validates :web_site, length:{minimum: 5}
    validates :description, presence:true,allow_blank: false

    validates :description, length:{minimum: 5}

end
