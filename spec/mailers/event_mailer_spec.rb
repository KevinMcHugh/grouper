require 'spec_helper'

describe EventMailer do
  context '#opt_out_mail' do
    let(:alice) {create :person}
    let(:event) {create :event}
    subject { EventMailer.opt_out_mail(event, alice)}
    it "does stuff" do
      expect(subject.header['X-Template'].to_s).to eq '{"name": "opt-out"}'
    end
  end
  context '#opt_in_mail' do
    let(:alice) {create :person}
    let(:event) {create :event}
    subject { EventMailer.opt_in_mail(event, alice)}
    it "does stuff" do
      expect(subject.header['X-Template'].to_s).to eq '{"name": "opt-in"}'
    end
  end
end