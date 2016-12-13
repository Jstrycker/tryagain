require 'rails_helper'

require 'spec_helper'
RSpec.describe "UsersEdits", type: :request do

    let(:user) { FactoryGirl.create(:user) }
    subject { user }

    it { should be_valid }
    describe "empty name" do
	before { user.name = '' }
	it { should_not be_valid }
    end

    describe "blank name" do
	before { user.name = ' ' }

	it { should_not be_valid }
    end

    describe "empty email" do
	before { user.email = '' }

	it { should_not be_valid }
    end

    describe "blank email" do
	before { user.email = ' ' }

	it { should_not be_valid }
    end

    describe "empty password" do
	before { user.password = '' }

	it { should_not be_valid }
    end

    describe "blank password" do
	before { user.password = ' ' }

	it { should_not be_valid }

    describe "long name" do
	before { user.name = 'a' * 51 }

	it { should_not be_valid }
    end

    describe "duplicate name" do
	let(:duplicate) do
	    d = user.dup
	    d.email = 'duplicate@example.com'
	    d
	end

	it "is not allowed" do
	    expect(duplicate).not_to be_valid
	end
    end

    describe "duplicate email" do
	let(:duplicate) do
	    d = user.dup
	    d.name = 'Jane Doe'
	    d
	end

	it "is not allowed" do
	    expect(duplicate).not_to be_valid
	end
    end




    end
end
