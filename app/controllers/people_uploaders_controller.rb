class PeopleUploadersController < ApplicationController
  def create
    people_uploader = PeopleUploader.new
    file = params["people_uploader"]["file"].read
    @people = people_uploader.upload file
  end
end
