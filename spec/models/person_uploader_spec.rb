require 'spec_helper'

describe PersonUploader do
  context '#create_people' do
    let(:yaml) do 
      "people:
      - name: alice
        team: ateam
        gender: :woman
        start_date: 2010-01-01
      - name: bob
        team: bteam
        gender: :man
        start_date: 2013-01-01"
    end
    let(:alice) {build(:person)}
    let(:bob) {build(:bob)}
    let(:people) {[alice, bob]}
    let(:person) {mock_model('Person').as_null_object}

    before(:each) do
      people.each do |person|
        person.stub(:save).and_return(true)
      end
    end
    subject{PersonUploader.new.create_people(people)}
    it "should save all the given People" do
      people.each do |person|
        expect(person).to receive(:save).once
      end
      expect(subject).to be_true
    end
  end

  context "#new" do
    subject {PersonUploader.new}
    it "should not blow up" do
    end
  end
end