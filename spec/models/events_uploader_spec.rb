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
  let(:group) {build(:group)}

  context "#upload" do
    before(:each) do
      group.event = event
    end

    subject {EventsUploader.new.upload yaml}
    it "parses and saves the data" do
      expect(subject).to eq event
      expect(subject.people).to match_array group.people
    end
  end
end