require 'spec_helper'

describe Person do
  let (:alice) {Person.new({name: "alice", gender: :woman, start: Date.iso8601("2010-01-01")})}
  let (:bob)   {Person.new({name: "bob",   gender: :man,   start: Date.iso8601("2013-01-01")})}
  let (:dan)   {Person.new({name: "dan",   gender: :trans, start: Date.iso8601("2013-01-01")})}

  describe '#new' do
    subject {Person.new({gender: "man"})}
    it 'should symbolize the argument' do
      expect(subject.man?).to be_true
      expect(subject.woman?).to be_false
    end
  end

  describe '#man?' do
    context 'when person is a woman' do
      subject {alice}
      it 'returns false' do
        expect(subject.man?).to be_false
      end
    end
    context 'when person is trans' do
      subject {dan}
      it 'returns false' do
        expect(subject.man?).to be_false
      end
    end
    context 'when person is a man' do
      subject {bob}
      it 'returns true' do
        expect(subject.man?).to be_true
      end
    end
  end

  describe '#woman?' do
    context 'when person is a woman' do
      subject {alice}
      it 'returns true' do
        expect(subject.woman?).to be_true
      end
    end
    context 'when person is trans' do
      subject {dan}
      it 'returns false' do
        expect(subject.woman?).to be_false
      end
    end
    context 'when person is a man' do
      subject {bob}
      it 'returns true' do
        expect(subject.woman?).to be_false
      end
    end
  end

  describe '#==' do
    subject {build(:person)}
    let(:alice) {build(:person)}
    let(:bob) {build(:bob)}

    context 'when objects are equal' do
      it {should == alice}
    end

    context 'when objects are not equal' do
      it {should_not == bob}
    end
  end 
end
