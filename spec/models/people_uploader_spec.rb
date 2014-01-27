require 'spec_helper'

describe PeopleUploader do
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

  context '#upload' do
    subject{PeopleUploader.new.upload yaml}
    it "saves all the given People" do
      expect(subject).to match_array people
    end
  end
end
