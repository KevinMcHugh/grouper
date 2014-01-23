require 'spec_helper'

describe Event do
    let(:event1) {create(:event)}
    let(:event2) {Event.create name: 'some name'}

    context "#new" do
      subject {event2}
      it "has the people from the previous event" do
        expect(event1.people).to_not be_empty
        expect(subject.people.map(&:name)).to match_array(event1.people.map(&:name))
      end
    end
    context "#add_group" do
      let(:group) {Group.new}
      subject {Event.new.add_group group}
      it "sets itself on the group" do
        expect(subject.groups).to match_array [group]
        expect(subject).to eq group.event
      end
    end
end
