require 'spec_helper'

describe EventMailer do
  context '#opt_in_or_out_mail' do
    let(:alice) {create :person}
    let(:event) {create :event}
    let(:e) {create :person, name: 'e'}
    let(:name) {'X-Template'}
    context "someone on the event" do
      subject { EventMailer.opt_in_or_out_mail(event, alice).header[name]}
      it "gets an opt-out mail" do
        expect(subject.to_s).to eq '{"name": "opt_out_mail"}'
      end
    end
    context "someone not on the event" do
      subject { EventMailer.opt_in_or_out_mail(event, e).header[name]}
      it "does stuff" do
        expect(subject.to_s).to eq '{"name": "opt_in_mail"}'
      end
    end
  end
end