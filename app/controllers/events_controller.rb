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
    GroupCreator.with_people_shims @event
    @event.save
    redirect_to event_path(@event)
  end

  def create_groups_with_shims
    @event = Event.find(params[:id])
    GroupCreator.both @event
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
    @disable_navbar = true
    add_or_remove_person do |event, person|
      event.add_person person
    end
  end

  def remove_person
    @disable_navbar = true
    add_or_remove_person do |event, person|
      event.remove_person person
    end
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

  def find_by_person_id?
    params.has_key? :person_id
  end

  def person
    if find_by_person_id?
      Person.find params[:person_id]
    else
      Person.find_by(uuid: params["person_uuid"])
    end
  end

  def add_or_remove_person
    @event = Event.find params[:id]
    @person = person
    yield @event, @person
    @event.save
    redirect_to event_path(@event) if find_by_person_id?
  end
end
