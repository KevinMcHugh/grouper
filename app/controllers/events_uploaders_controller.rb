class EventsUploadersController < ApplicationController
  def create
    events_uploader = EventsUploader.new
    file = params["events_uploader"]["file"].read
    @event = events_uploader.upload file
    @people = @event.people
    redirect_to event_path(@event)
  end
end