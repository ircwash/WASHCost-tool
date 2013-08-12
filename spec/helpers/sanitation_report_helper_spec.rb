require_relative  '../spec_helper'

describe SanitationReportHelper, :type => :helper do
  subject { Class.new.include SanitationReportHelper }

  describe "#get_total" do
    it "should return a valid total" do
       capital, recurrent, population = 61, 3, 2000
       expect(get_total(capital, recurrent, population)).to eq(182000)
    end
  end

  describe "#is_ready_form" do
    let (:complete_form) {
        { :latrine => 1, :capital => 1, :recurrent => 2, :reliability => 1 }
      }
    let (:incomplete_form) {
        { :latrine => 1, :capital => 1, :recurrent => nil, :reliability => 1 }
      }
    context "when the form is complete" do
      it "should be true" do
        expect(is_form_ready?(complete_form)).to be_true
      end
    end
    context "when the form is incomplete" do
      it "should be false" do
        expect(is_form_ready?(incomplete_form)).to be_false
      end
    end
  end

  describe "#get_service_rating_label" do
    context "when has one star" do
      it "should read No service" do
        expect(get_service_rating_label(0)).to eq(t 'report.sustainability.sanitation.one_star')
      end
    end
    context "when has two stars" do
      it "should read Sub-standard service" do
        expect(get_service_rating_label(1)).to eq(t 'report.sustainability.sanitation.two_stars')
      end
    end
    context "when has three stars" do
      it "should read Basic service" do
        expect(get_service_rating_label(2)).to eq(t 'report.sustainability.sanitation.three_stars')
      end
    end
    context "when has four stars" do
      it "should read High standard service" do
        expect(get_service_rating_label(3)).to eq(t 'report.sustainability.sanitation.four_stars')
      end
    end
  end

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
