class User < ActiveRecord::Base
    has_secure_password

    validates :name, presence: true
    validates :name, length:{minimum: 2}
    validates :name, length:{maximum: 30}
    validates :name, uniqueness: true, on: :create
    validates :email, presence: true
    validates :email, uniqueness: true, on: :create	
    validates :password, presence: true
    validates :password, length:{minimum: 5}
end
