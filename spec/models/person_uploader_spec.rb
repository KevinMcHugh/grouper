require 'spec_helper'

describe PersonUploader do
  let(:alice) {build(:person)}
  let(:bob) {build(:bob)}
  let(:people) {[alice, bob]}
  let(:yaml) do 
    "people:
    - name: alice
      team: ateam
      gender: :woman
      start: 2010-01-01
    - name: bob
      team: bteam
      gender: :man
      start: 2013-01-01"
  end

  context '#create_people' do
    let(:person) {mock_model('Person').as_null_object}

    before(:each) do
      people.each do |person|
        person.stub(:save).and_return(true)
      end
    end
    subject{PersonUploader.new.create_people(people)}
    it "saves all the given People" do
      people.each do |person|
        expect(person).to receive(:save).once
      end
      expect(subject).to be_true
    end
  end

  context '#parse' do
    subject {PersonUploader.new.parse yaml}
    it "parses the file" do
      expect(subject).to match_array people
    end 
  end

  context '#upload' do
    let(:person_uploader) {PersonUploader.new}

    subject {person_uploader.upload yaml}
    it "parses and saves the data" do
      person_uploader.should_receive(:parse).and_call_original
      person_uploader.should_receive(:create_people).with(people).and_call_original
      expect(subject).to match_array people
    end
  end
end