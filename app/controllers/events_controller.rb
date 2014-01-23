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
    @event = Event.find(params[:id])
    if !@event.groups.empty?
      group_text = @event.groups.map.with_index(1) do |g, i|
        ["Group #{i}"] + g.people.map {|p| p.name}
      end
      max_size = group_text.max {|r1, r2| r1.size <=> r2.size}.size
      group_text.each {|r| r[max_size - 1] ||= nil }
      @group_table = group_text.transpose
    end
    @people = @event.people
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  def create_groups
    @event = Event.find(params[:id])
    groups = GroupSelector.select(@event.people.to_a)
    @event.groups = groups
    @event.save
    groups.each do |group|
      group.event = @event
      group.save
    end
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
    people = @event.people.to_a
    people.delete_if {|p| p == person}
    @event.people = people
    @event.save
    redirect_to event_path(@event)
  end

  def announce
    @event = Event.find(params[:id])
    went_last_time = @event.previous_event.people.to_a
    went_last_time.map do |person|
      EventMailer.opt_out_mail(@event, person).deliver
    end
    others = Person.all.to_a - went_last_time
    others.map do |person|
      EventMailer.opt_in_mail(@event, person).deliver
    end
    redirect_to email_sent_event_path
  end

  def send_email
    @event = Event.find(params[:id])
    EventMailer.event_mail @event
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
