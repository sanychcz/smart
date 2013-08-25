class EmployeesController < ApplicationController
 
	def new
		@company = Company.find(params[:company_id])
		@employee = @company.employees.build
	end

	def create
		@company = Company.find(params[:company_id])
		@employee = @company.employees.build(params[:employee])
		if @employee.save
			redirect_to @company
		else
			render 'new'
		end	
	end

	def show
		@employee = Employee.find(params[:id])
	end

	 def index
	  @employees = Employee.search(params[:search])
	  respond_to do |format|
	    format.html
	    format.csv { send_data Employee.to_csv }
	  end
	end

	def edit
		@company = Company.find(params[:company_id])
		@employee = Employee.find(params[:id])
	end

	def update
		@company = Company.find(params[:company_id])
		@employee = @company.employees.find(params[:id])
		if @employee.update_attributes(params[:employee])
			redirect_to company_employee_path(@company, @employee)
		else
			render 'edit'
		end
	end

	def destroy
		@company = Company.find(params[:company_id])
		@company.employees.find(params[:id]).destroy 
		redirect_to @company
	end
end
