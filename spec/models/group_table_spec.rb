require 'spec_helper'

describe GroupTable do
  context "#new" do
    subject {GroupTable.create build(:event)}
    it "transposes the arrays" do 
      expect(subject).to match_array [["Group 1"], ["alice"], ["bob"], ["carol"], ["dan"]]
    end
  end
end