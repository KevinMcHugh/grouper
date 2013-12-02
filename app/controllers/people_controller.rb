class PeopleController < ApplicationController
	def index
		@people = Person.all
	end

	def create
		@person = Person.new(person_params)
 		@person.save
  		redirect_to @person
	end

	def show
  		@person = Person.find(params[:id])
	end
	def destroy
		@person = Person.find(params[:id])
		@person.destroy
		redirect_to people_path
	end

	private
  		def person_params
      		params.required(:person).permit(:name, :gender, :start)
    	end
end
