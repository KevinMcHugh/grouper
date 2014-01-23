class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def create
    groups = GroupSelector.select(Person.all.to_a)
    params.merge!({groups: groups})
    @event = Event.new(event_params)
    @event.save
    groups.each do |group|
      group.event = @event
      group.save
    end
    redirect_to events_path(@event)
  end

  def show
    @event = Event.find(params[:id])
    group_text = @event.groups.map.with_index(1) do |g, i|
      ["Group #{i}"] + g.people.map {|p| p.name}
    end
    max_size = group_text.max {|r1, r2| r1.size <=> r2.size}.size
    group_text.each {|r| r[max_size - 1] ||= nil }
    @group_table = group_text.transpose
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  def send_email
    @event = Event.find(params[:id])
    EventMailer.event_mail(@event)
    redirect_to email_sent_event_path
  end

  def email_sent
    @event = Event.find(params[:id])
  end

  private 
  def event_params
    params.required(:event).permit(:groups, :name)
  end
end
