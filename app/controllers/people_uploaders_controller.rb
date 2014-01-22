class PeopleUploadersController < ApplicationController
  def create
    person_uploader = PersonUploader.new
    file = params["people_uploader"]["file"].read
    @people = person_uploader.upload file
    render "people/index"
  end
end