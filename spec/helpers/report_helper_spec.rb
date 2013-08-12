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

  describe "#rating_for_expenditure" do
    min, max = 3, 7
    pairs = [ [0, 0.5], [1, 0.5], [2, 0.5], [3, 2], [4, 2], [5, 2], [6, 2], [7, 2],
             [8, 1], [9, 1], [10, 1] ]
    pairs.each do |pair|
      context "when value is #{pair[0]} with min = #{min} and max = #{max}" do
        it "should be #{pair[1]}" do
          expect(rating_for_expenditure(pair[0], min, max)).to eq(pair[1])
        end
      end
    end
  end

  describe "#rating_for_service_level" do
    context "when is high" do
      it "should be 1.5" do
        expect(rating_for_service_level(3)).to eq(1.5)
      end
    end

    context "when is basic" do
      it "should be 1.5" do
        expect(rating_for_service_level(2)).to eq(1)
      end
    end

    context "when is sub-standard" do
      it "should be 0.25" do
        expect(rating_for_service_level(1)).to eq(0.25)
      end
    end

    context "when there no service" do
      it "should be 0" do
        expect(rating_for_service_level(0)).to eq(0)
      end
    end
  end
end
