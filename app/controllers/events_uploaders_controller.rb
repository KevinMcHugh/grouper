class EventsUploadersController < ApplicationController
  def create
    events_uploader = EventsUploader.new
    file = params["events_uploader"]["file"].read
    @event = events_uploader.upload file
    render 'events/show'
  end
end