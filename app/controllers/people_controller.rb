# Everything you might need to do with People
class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def create
    @person = Person.new(person_params)
    @person.save
    redirect_to people_path
  end

  def show
    @person = Person.find(params[:id])
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to people_path
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(params[:person].permit(allowed_params))
      redirect_to person_path(@person)
    else
      render 'edit'
    end
  end

  private
      def person_params
          params.required(:person).permit(allowed_params)
      end

      def allowed_params
       [:name, :email_address, :gender, :start, :team]
      end
end
