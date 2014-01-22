class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def create
    groups = GroupSelector.select(Person.all)
    params.merge!({groups: groups})
    @event = Event.new(event_params)
    @event.save
    groups.each do |group|
      group.event = @event
      group.save
    end
    redirect_to @event
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private 
  def event_params
    params.required(:event).permit(:groups, :name)
  end
end
