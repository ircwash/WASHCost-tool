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

  describe "#get_capEx_benchmark_rating" do
    context "when below benchmarks" do
      it "should be 0.5" do
        latrineIndex, expense = 0, 6
        expect(get_capEx_benchmark_rating(latrineIndex, expense)).to eq(0.5)
      end
    end

    context "when within benchmarks" do
      it "should be 2" do
        latrineIndex, expense = 0, 25
        expect(get_capEx_benchmark_rating(latrineIndex, expense)).to eq(2)
      end
    end

    context "when above benchmarks" do
      it "should be 1" do
        latrineIndex, expense = 0, 27
        expect(get_capEx_benchmark_rating(latrineIndex, expense)).to eq(1)
      end
    end
  end

  describe "#get_recEx_benchmark_rating" do
    context "when below benchmarks" do
      it "should be 0.5" do
        latrineIndex, expense = 0, 1
        expect(get_recEx_benchmark_rating(latrineIndex, expense)).to eq(0.5)
      end
    end

    context "when within benchmarks" do
      it "should be 2" do
        latrineIndex, expense = 0, 3.5
        expect(get_recEx_benchmark_rating(latrineIndex, expense)).to eq(2)
      end
    end

    context "when above benchmarks" do
      it "should be 1" do
        latrineIndex, expense = 0, 7
        expect(get_recEx_benchmark_rating(latrineIndex, expense)).to eq(1)
      end
    end
  end
end
