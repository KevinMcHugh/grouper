# Create, delete, send mail, invite people, add people to events
class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to event_path(@event)
  end

  def show
    event = Event.find(params[:id])
    @event_dto = EventDTO.new event
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  def create_groups
    @event = Event.find(params[:id])
    groups = GroupSelector.select(@event.people.to_a)
    @event.add_groups groups
    groups.map &:save
    @event.save
    redirect_to event_path(@event)
  end

  def add_all_people
    @event = Event.find(params[:id])
    @event.people = Person.all
    @event.save
    redirect_to event_path(@event)
  end

  def add_person
    @event = Event.find(params[:id])
    person = Person.find(params[:person_id])
    @event.add_person person
    @event.save
  end

  def remove_person
    @event = Event.find(params[:id])
    person = Person.find(params[:person_id])
    @event.remove_person person
    @event.save
    redirect_to event_path(@event)
  end

  def announce
    @event = Event.find(params[:id])
    Person.all.to_a.each do |person|
      EventMailer.opt_in_or_out_mail(@event, person).deliver
    end
    redirect_to email_sent_event_path
  end

  def send_email
    @event = Event.find(params[:id])
    @event.groups.map do |group|
      EventMailer.group_mail(group, @event.name).deliver
    end
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
