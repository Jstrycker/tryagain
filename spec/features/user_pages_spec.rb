require 'spec_helper'
describe "User Pages" do
	subject{ page}
	describe "show users" do
		describe 'all' do
			before do
				25.times do |i|
User.create( name: "Some#{i}",  
email: "someemail#{i}@exam.xom", password: "SomePassword#{i}"
)
				end
				visit '/users'
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


