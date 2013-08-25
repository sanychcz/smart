require 'spec_helper'

describe Employee do
  let(:company) { FactoryGirl.create(:company) }

  before { @employee = FactoryGirl.create(:employee) }

 	  subject { @employee }

 	  it { should respond_to(:name) }
 	  it { should respond_to(:surname) }
 	  it { should respond_to(:email) }
 	  it { should respond_to(:phone) }
 	  it { should respond_to(:address) }
 	  it { should respond_to(:birthday) }
 	  it { should respond_to(:position) }
 	  it { should respond_to(:company_id) }

 	  it { should be_valid }

    describe "when company_id is not present" do
      before { @employee.company_id = "" }
      it { should_not be_valid }
    end

 	  describe "when name is not present" do
 	  	before { @employee.name = "" }
 	  	it { should_not be_valid }
 	  end

 	  describe "when surname is not present" do
 	  	before { @employee.surname = "" }
 	  	it { should_not be_valid }
 	  end

 	  describe "when email is not present" do
 	  	before { @employee.email = "" }
 	  	it { should_not be_valid }
 	  end

 	  describe "when phone is not present" do
 	  	before { @employee.phone = nil }
 	  	it { should_not be_valid }
 	  end

 	  describe "when email format is invalid" do
		it "should be invalid" do
			invalid_emails = %w[comapny@foo,com company_at_foo.org example.company@foo.
                     foo@bar_baz.com foo@bar+baz.com]
    	invalid_emails.each do |invalid_email|
    		@employee.email = invalid_email 
    		expect(@employee).not_to be_valid                
    	end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			valid_emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    	valid_emails.each do |valid_email|
    		@employee.email = valid_email 
    		expect(@employee).to be_valid               
    	end
		end
	end
end
