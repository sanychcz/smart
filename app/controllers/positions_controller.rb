class PositionsController < ApplicationController
  
	def new
		@company = Company.find(params[:company_id])
		@position = @company.positions.build
	end

	def create
		@company = Company.find(params[:company_id])
		@position = @company.positions.build(params[:position])
		if @position.save
			redirect_to @company
		else 
			render 'new'
		end			
	end

	def show
		@position = Position.find(params[:id])
	end

	def index
		@positions = Position.all
	end
end
