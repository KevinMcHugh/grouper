# Lets you upload an event with groups all at once
class EventsUploadersController < ApplicationController
  def create
    file = params["events_uploader"]["file"].read
    event = EventsUploader.new.upload file
    event.save
    @event_dto = EventDTO.new event
  end
end