require_relative  '../spec_helper'

describe WaterReportHelper, :type => :helper do
  subject {
    class Test_report
      include WaterReportHelper
    end.New
  }

  describe "#get_total" do
    it "should return a valid total" do
       capital, recurrent, population = 61, 3, 2000
       expect(get_total(capital, recurrent, population)).to eq(182000)
    end
  end

  describe "#get_capEx_benchmark_rating" do

    context "When below benchmarks" do
      it "should be 0.5" do
        waterSourceIndex, expense = 0, 19
        expect(get_capEx_benchmark_rating(waterSourceIndex, expense)).to eq(0.5)
      end
    end

    context "When within benchmarks" do
      it "should be 2" do
        waterSourceIndex, expense = 0, 21
        expect(get_capEx_benchmark_rating(waterSourceIndex, expense)).to eq(2)
      end
    end

    context "When above benchmarks" do
      it "should be 1" do
        waterSourceIndex, expense = 0, 62
        expect(get_capEx_benchmark_rating(waterSourceIndex, expense)).to eq(1)
      end
    end

  end

  describe "#get_recEx_benchmark_rating" do

    context "When below benchmarks" do
      it "should be 0.5" do
        waterSourceIndex, expense = 0, 2
        expect(get_recEx_benchmark_rating(waterSourceIndex, expense)).to eq(0.5)
      end
    end

    context "When within benchmarks" do
      it "should be 2" do
        waterSourceIndex, expense = 0, 5
        expect(get_recEx_benchmark_rating(waterSourceIndex, expense)).to eq(2)
      end
    end

    context "When above benchmarks" do
      it "should be 1" do
        waterSourceIndex, expense = 0, 7
        expect(get_recEx_benchmark_rating(waterSourceIndex, expense)).to eq(1)
      end
    end

  end

  describe "#rating_for_service_level" do

    context "When is high" do
      it "should be 1.5" do
        expect(rating_for_service_level(3)).to eq(1.5)
      end
    end

    context "When is basic" do
      it "should be 1.5" do
        expect(rating_for_service_level(2)).to eq(1)
      end
    end

    context "When is sub-standard" do
      it "should be 0.25" do
        expect(rating_for_service_level(1)).to eq(0.25)
      end
    end

    context "When there no service" do
      it "should be 0" do
        expect(rating_for_service_level(0)).to eq(0)
      end
    end

  end

  describe "#normalise_best_level_to_be_3" do

    context "When is 3" do
      it "should be 0" do
        expect(normalise_best_level_to_be_3(3)).to eq(0)
      end
    end

    context "When is 2" do
      it "should be 1" do
        expect(normalise_best_level_to_be_3(2)).to eq(1)
      end
    end

    context "When is 1" do
      it "should be 2" do
        expect(normalise_best_level_to_be_3(1)).to eq(2)
      end
    end

    context "When is 0" do
      it "should be 3" do
        expect(normalise_best_level_to_be_3(0)).to eq(3)
      end
    end

  end

  describe "#get_rating" do

    context "When using: Borehole & handpump, capital ex = 18, recurrent ex = 4, \
              accessibility = 0, quality = 3, quantity = 3, reliability = 0" do
      it "should be 3 stars"  do
        water = 0
        capital, recurring = 18, 4
        accessibility, quality, quantity, reliability = 0, 3, 3, 0
        expect(get_rating(water, capital, recurring, accessibility,
               quality, quantity, reliability)).to eq(3)
      end
    end

    context "When an argument is nil" do
      it "should be nil" do
        expect(get_rating(0, 1, 1, 0, nil, 3, 0)).to be_nil
      end
    end

  end
end
