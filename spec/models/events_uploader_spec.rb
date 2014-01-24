require 'spec_helper'

describe EventsUploader do
  let(:yaml) do
    "
    name: test_event
    groups:
    -
     - alice
     - bob
     - carol
     - dan"
   end
  let(:event) {build(:event)}
  let(:event_uploader) {EventsUploader.new}
  let(:group) {build(:group)}

  context "#upload" do
    before(:each) do
      group.event = event
    end

    subject {event_uploader.upload yaml}
    it "parses and saves the data" do
      event_uploader.should_receive(:parse).and_call_original
      event_uploader.should_receive(:create_event).with(event).and_call_original
      expect(subject).to eq event
      expect(subject.people).to match_array group.people
    end
  end
end