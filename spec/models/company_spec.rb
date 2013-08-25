require 'spec_helper'

describe Company do
  
  before do
  	@company = FactoryGirl.create(:company)
  end

  subject {@company}

  it {should respond_to (:name)}
  it {should respond_to (:email)}
  it {should respond_to (:web)}
  it {should respond_to (:address)}
  it {should respond_to (:phone)}
  it {should respond_to (:ico)}
  it {should respond_to (:dic)}
  it {should respond_to (:employees)}
  it {should respond_to (:positions)}

  it {should be_valid}

  describe "when name is not present" do
		before { @company.name = "" }
		it { should_not be_valid }
	end

	describe "when phone is not present" do
		before { @company.phone = nil }
		it { should_not be_valid }
	end

	describe "valid phone number size" do
		before { @company.phone = 1234 }
		it { should_not be_valid }
	end

	describe "valid phone format" do
		before { @company.phone = 123412349 }
		its (:phone){ should be_kind_of(Integer)}
	end

	describe "when ico is not present" do
		before { @company.ico = nil }
		it { should_not be_valid }
	end

	describe "valid ico format" do
		before { @company.ico = 12312312 }
		its (:ico){ should be_kind_of(Integer)}
	end

	describe "valid dic format" do
		before { @company.dic = 12312312 }
		its (:dic){ should be_kind_of(Integer)}
	end

	describe "when email is not present" do
		before { @company.email = "" }
		it { should_not be_valid } 
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			invalid_emails = %w[comapny@foo,com company_at_foo.org example.company@foo.
                     foo@bar_baz.com foo@bar+baz.com]
    	invalid_emails.each do |invalid_email|
    		@company.email = invalid_email 
    		expect(@company).not_to be_valid                
    	end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			valid_emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    	valid_emails.each do |valid_email|
    		@company.email = valid_email 
    		expect(@company).to be_valid               
    	end
		end
	end
end
