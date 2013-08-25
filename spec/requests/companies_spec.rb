require 'spec_helper'

describe "Companies" do

	subject { page }
	
	let(:company) {FactoryGirl.create(:company)}

	describe "index page" do
		let(:company) {FactoryGirl.create(:company)}

		before {visit companies_path}

		it { should have_title "Všechny společnosti" }
		it { should have_selector(".row table") }
	end

	describe "show page" do
		let(:company) {FactoryGirl.create(:company)}

		before { visit company_path(company) }
		it { should have_title(company.name) }
	end

	describe "new company page" do

		before { visit new_company_path }

		it { should have_title "Nová společnost" }

		describe "with invalid information" do

			it "should not create a company" do
			  expect { click_button "Uložit společnost" }.not_to change(Company, :count)
			end

			describe "error messages" do
			  before { click_button "Uložit společnost" }
			  it { should have_content('error') }
			end
		end

		describe "with valid information" do
			let(:company) {FactoryGirl.build(:company)}

			before do
				fill_in "Název", with: company.name
				fill_in "Email", with: company.email
				fill_in "Adresa", with: company.address
				fill_in "Telefon", with: company.phone
				fill_in "Web", with: company.web
				fill_in "IČO", with: company.ico
				fill_in "DIČ", with: company.dic
			end	

			it "should create new company" do
        expect { click_button "Uložit společnost" }.to change(Company, :count).by(1)
        page.should have_content(company.name)
      end
		end
	end

	describe "edit company page" do
		before { visit edit_company_path(company) }

		it { should have_title "Úprava společnosti" }

		describe "update with invalid information" do
			let(:new_nazev) { "Wrong title" }
			let(:new_ico) { 1 }

			before do
				fill_in "Název", with: new_nazev
				fill_in "IČO", with: new_ico
				click_button "Uložit společnost"
			end

			it { should_not have_title(new_nazev) }
		end

		describe "update with valid information" do
			let(:new_nazev) { "Nice title" }
			let(:new_ico) { 12345678 }

			before do
				fill_in "Název", with: new_nazev
				fill_in "IČO", with: new_ico
				click_button "Uložit společnost"
			end

			it { should have_title(new_nazev) }

			specify { company.reload.name.should  == new_nazev }
			specify { company.reload.ico.should  == new_ico }
		end
	end

	describe "delete company" do
		before do 
			FactoryGirl.create(:company)
			visit companies_path 	
		end

		it "should delete company" do
			expect {click_link "Smazat"}.to change(Company, :count).by(-1)
			current_path.should == companies_path
		end 
	end
end
