require 'spec_helper'

describe EventDTO do
  context '#group_table' do
    context 'when there are no groups' do
      let(:event) {Event.new}
      subject {EventDTO.new event}
      it 'has no group table' do
        expect(subject.group_table).to be_nil
      end
    end
    context 'when there are groups' do
      let(:event) {build :event}
      subject {EventDTO.new event}
      it 'returns a properly transposed array' do
        expect(subject.group_table).to match_array [["Group 1"], ["alice"], ["bob"], ["carol"], ["dan"]]
      end
    end
  end
  context '#people' do
    context 'when there are no people' do
      let(:event) {Event.new}
      subject {EventDTO.new event}
      it 'has an empty array' do
        expect(subject.people).to be_empty
      end 
    end
    context 'when there are people' do
      let(:event) {build :event}
      let(:alice) {build :person}
      let(:bob)   {build :bob}
      let(:carol) {build :carol}
      let(:dan)   {build :dan}

      subject {EventDTO.new event}
      it 'returns a properly transposed array' do
        expect(subject.people).to match_array [alice, bob, carol, dan]
      end
    end
  end
end