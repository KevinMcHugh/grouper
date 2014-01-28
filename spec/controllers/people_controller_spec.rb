require 'spec_helper'

describe PeopleController do
  describe '#create' do
    let(:person) {double(Person).as_null_object}

    before(:each) do
      Person.stub(:new).and_return person
    end
    it 'saves people' do
      expect(Person).to receive(:new).once
      expect(person).to receive(:save).once
      post :create, person: {name: 'alice'}
    end
  end
end