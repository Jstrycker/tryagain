FactoryGirl.define do
	factory :user do
	sequence (:name) {|i|"User #{i}"}
	sequence (:email) {|i| "User#{i}@gmail.com"}
	password 'password'
	end
end
