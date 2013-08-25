require 'spec_helper'

describe Position do
 	
	before do
		@position = FactoryGirl.create(:position)
	end

	subject {@position} 

	it { should respond_to(:name) }
	it { should respond_to(:company_id) }

	it { should be_valid }

	describe "when name is not present" do
		before { @position.name = "" }
		it { should_not be_valid }
	end

	describe "when company_id is not present" do
		before { @position.company_id = "" }
		it { should_not be_valid }
	end
end
