require_relative  '../spec_helper'

describe ReportHelper, :type => :helper do

  subject { Class.new.include ReportHelper }

  describe "#compute_rating_from_score" do
    pairs = [ [0, 0], [1, 0], [2, 1], [3, 1], [4, 1], [5, 2], [6, 2], [7, 2],
             [7.5, 3], [8, 3], [9, 3], [10, 3] ]
    pairs.each do |pair|
      context "when score is #{pair[0]}" do
        it "should be #{pair[1]}" do
          expect(compute_rating_from_score(pair[0])).to eq(pair[1])
        end
      end
    end
  end

end
