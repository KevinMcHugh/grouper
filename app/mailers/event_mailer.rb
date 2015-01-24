# Handles sending of emails for anything event-related.
class EventMailer < ActionMailer::Base
  def group_mail group, event_name
    email_addresses = group.people.map(&:email_address)
    mail(to: email_addresses, from: from, subject: event_name)
  end

  def opt_in_or_out_mail event, person
    @person = person
    @event = event
    if @event.people.include? person
      template = "opt_out_mail"
    else
      template = "opt_in_mail"
    end
    headers['X-Template'] = '{"name": "' + template + '"}'
    mail(to: person.email_address,
         from: from,
         subject: event.name,
         template_name: template)
  end

  private
  def from; 'no_reply@example.com'; end
end
