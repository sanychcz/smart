class CompaniesController < ApplicationController
  
	def new
		@company = Company.new
	end

	def create
		@company = Company.new(params[:company])
		if @company.save
			flash[:success] = "Company updated!"
			redirect_to @company
		else
			render 'new'
		end	 
	end

	def index
		@companies = Company.search(params[:search])
		respond_to do |format|
		  format.html
		  format.csv { send_data Company.to_csv }
		end
	end

	def show
		@company = Company.find(params[:id])
	end

	def edit
		@company = Company.find(params[:id])
	end

	def update
		@company = Company.find(params[:id])
		if @company.update_attributes(params[:company])
			flash[:success] = "Company updated!"
		  redirect_to @company
		else
		  render "edit"
		end 
	end 

	def destroy
		Company.find(params[:id]).destroy
		redirect_to companies_path
	end
  
end
