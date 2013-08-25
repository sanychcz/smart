require 'spec_helper'

describe "Employees" do
  
	subject { page }

	let(:company) {FactoryGirl.create(:company)}
	let(:employee) {FactoryGirl.create(:employee)}
	let(:position) {FactoryGirl.create(:position)}

	describe "index page" do
		before { visit employees_path }
		it { should have_title "Všichni zaměstnanci" }
		it { should have_selector("table") }
		it { should have_content("export to:") }
		it { should have_link("CSV") }
	end

	describe "show page" do
		before { visit company_employee_path(company, employee) }
		it { should have_title employee.name }
		it { should have_link("zpět na profil společnosti") }

		describe "click redirect link to company page" do
			before { click_link "zpět na profil společnosti" }
			it "should have company name" do
				page.should have_content employee.company.name
			end
		end	
	end

	describe "new page" do
		before { visit new_company_employee_path(company) }
		it { should have_title "Nový zaměstnanec" }

		describe "with invalid information" do

			it "should not create employee" do
				expect { click_button "Uložit zaměstnance" }.not_to change(Employee, :count)
			end

			describe "error messages" do
			  before { click_button "Uložit zaměstnance" }
			  it { should have_content('error') }
			end
		end

		describe "with valid information" do
			let(:employee) {FactoryGirl.build(:employee, :company_id => company.id, :position => "Manager")}

			before do
				fill_in "Jméno", with: employee.name
				fill_in "Příjmení", with: employee.surname
				fill_in "Adresa", with: employee.address
				fill_in "Telefon", with: employee.phone
				fill_in "Email", with: employee.email
				select "1980", :from => 'employee_birthday_1i'
				select "January", :from => 'employee_birthday_2i'
				select "10", :from => 'employee_birthday_3i'
			end	

			it "should create new employee" do
        expect { click_button "Uložit zaměstnance" }.to change(Employee, :count).by(1)
        page.should have_content employee.company.name
      end
		end
	end

	describe "edit page" do
		let(:employee) {FactoryGirl.create(:employee, :company_id => company.id)}
		before { visit edit_company_employee_path(company, employee) }

		it { should have_title "Úprava zaměstnance" }

		describe "update with invalid data" do

			let(:new_jmeno) { "Wrong name" }
			let(:new_phone) { 1123 }

			before do 
				fill_in "Jméno", with: new_jmeno
				fill_in "Telefon", with: new_phone
				click_button "Uložit zaměstnance"
			end
			it { should_not have_title(new_jmeno) }
		end

		describe "with valid data" do

			let(:new_jmeno) { "Correct name" }
			let(:new_phone) { 999999999 }	

			before do 
				fill_in "Jméno", with: new_jmeno
				fill_in "Telefon", with: new_phone
				click_button "Uložit zaměstnance"
			end
			it { should have_title(new_jmeno) }

			specify { employee.reload.name.should  == new_jmeno }
			specify { employee.reload.phone.should  == new_phone }
		end	
	end

	describe "delete emplyee from companies page" do
		before do
			FactoryGirl.create(:employee, :company_id => company.id)
			visit company_path(company) 
		end
		it { should have_link "smazat" }

		it "should delete employee" do
			expect { click_link "smazat" }.to change(Employee, :count).by(-1)
		end
	end

	describe "delete employee from employee page" do
		before do
			FactoryGirl.create(:employee, :company_id => company.id)
			visit company_employee_path(company, employee) 
		end
		it { should have_link "smazat" }

		it "should delete employee" do
			expect { click_link "smazat" }.to change(Employee, :count).by(-1)
		end
	end
end
