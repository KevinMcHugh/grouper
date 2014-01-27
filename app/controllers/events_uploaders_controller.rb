class EventsUploadersController < ApplicationController
  def create
    events_uploader = EventsUploader.new
    file = params["events_uploader"]["file"].read
    @event = events_uploader.upload file
    redirect_to event_path(@event)
  end
end