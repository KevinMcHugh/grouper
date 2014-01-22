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

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(params[:person].permit(:name, :gender, :start, :team))
      redirect_to @person
    else
      render 'edit'
    end
  end

  private
      def person_params
          params.required(:person).permit(:name, :gender, :start, :team)
      end
end
