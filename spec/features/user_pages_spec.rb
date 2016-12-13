require 'spec_helper'
describe "User Pages" do
	subject{ page}
	describe "show users" do
		describe 'all' do
			before do
		25.times {|i| FactoryGirl.create(:user)}
				visit users_path
			end
	it{should have_content('List of users')}
	it{should have_content('25 users')}
	it "should show all users" do
		User.all.each do |user|
			should have_selector("li", text: user.name)
			should have_selector("li", text: user.email)
			end
		end
		end
	end



end


describe "creating User" do
   	before {visit new_user_path}
		it "Hides password test" do 
			should have_field('user_password' ,type: 'password')
		end

	describe "with invalid information" do
		it "does not add new user" do

			expect{click_button 'Submit' }.not_to change(User, :count)

		end

		it 'produces error message'do

			should have_alert(:danger)
		end
	end


	describe "With valid information" do
		before do
			fill_in 'Username', with: "Username"
			fill_in 'Email', with: "Something@taylor.edu"
			fill_in 'password', with: "SecurePassword"
		end

		it "allows the user to fill the feilds" do
			click_button 'Submit'
		end
	
		it "does add new user" do

			expect{click_button 'Submit' }.to change(User, :count).by(1)

		end
	
		describe 'produces welcome message' do
	
			before do 
				click_button 'Submit'
				end 

			should have_alert(:success, text: 'Welcome')
		end

		end

	end
