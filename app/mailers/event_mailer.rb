class EventMailer < ActionMailer::Base
  def event_mail event
    event.groups.each do |group|
      email_addresses = group.people.map(&:email_address)
      mail(to: email_addresses, subject: event.name).deliver
    end
  end

  def opt_in_mail event, person
    @person = person
    @event = event
    mail(to: person.email_address, subject: event.name)
  end

  def opt_out_mail event, person
    @person = person
    @event = event
    mail(to: person.email_address, subject: event.name)
  end
end
