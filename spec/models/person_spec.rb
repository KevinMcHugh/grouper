require 'spec_helper'

describe Person do
  let (:alice) {build(:person)}
  let (:bob) {build(:bob)}
  let (:dan) {build(:dan)}

  describe '#new' do
    subject {bob}
    it 'should symbolize the argument' do
      expect(subject.gender).to eq :man
    end
  end

  describe '#==' do
    subject {build(:person)}

    context 'when objects are equal' do
      it {should == alice}
    end

    context 'when objects are not equal' do
      it {should_not == bob}
    end
  end
end
