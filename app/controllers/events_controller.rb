class EventsController < ApplicationController
	def index
		@events = Event.all
	end

	def create
		group_arrays = GroupSelector.select(Person.all)
		groups = group_arrays.map do |group_array| 
			group = Group.new people: group_array
			group.save
			group
		end
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
		puts @event
	end

	private 
	def event_params
		params.required(:event).permit(:groups, :name)
	end
end
