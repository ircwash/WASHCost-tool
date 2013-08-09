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

    describe "When below benchmarks" do
      it "should be 0.5" do
        waterSourceIndex, expense = 0, 19
        expect(get_capEx_benchmark_rating(waterSourceIndex, expense)).to eq(0.5)
      end
    end

    describe "When within benchmarks" do
      it "should be 2" do
        waterSourceIndex, expense = 0, 21
        expect(get_capEx_benchmark_rating(waterSourceIndex, expense)).to eq(2)
      end
    end

    describe "When above benchmarks" do
      it "should be 1" do
        waterSourceIndex, expense = 0, 62
        expect(get_capEx_benchmark_rating(waterSourceIndex, expense)).to eq(1)
      end
    end

  end

  describe "#get_recEx_benchmark_rating" do

    describe "When below benchmarks" do
      it "should be 0.5" do
        waterSourceIndex, expense = 0, 2
        expect(get_recEx_benchmark_rating(waterSourceIndex, expense)).to eq(0.5)
      end
    end

    describe "When within benchmarks" do
      it "should be 2" do
        waterSourceIndex, expense = 0, 5
        expect(get_recEx_benchmark_rating(waterSourceIndex, expense)).to eq(2)
      end
    end

    describe "When above benchmarks" do
      it "should be 1" do
        waterSourceIndex, expense = 0, 7
        expect(get_recEx_benchmark_rating(waterSourceIndex, expense)).to eq(1)
      end
    end

  end

  describe "#rating_for_service_level" do

    describe "When is high" do
      it "should be 1.5" do
        expect(rating_for_service_level(3)).to eq(1.5)
      end
    end

    describe "When is basic" do
      it "should be 1.5" do
        expect(rating_for_service_level(2)).to eq(1)
      end
    end

    describe "When is sub-standard" do
      it "should be 0.25" do
        expect(rating_for_service_level(1)).to eq(0.25)
      end
    end

    describe "When there no service" do
      it "should be 0" do
        expect(rating_for_service_level(0)).to eq(0)
      end
    end

  end


  describe "#move_highest_level_to_the_right" do

    describe "When is 3" do
      it "should be 0" do
        expect(move_highest_level_to_the_right(3)).to eq(0)
      end
    end

    describe "When is 2" do
      it "should be 1" do
        expect(move_highest_level_to_the_right(2)).to eq(1)
      end
    end

    describe "When is 1" do
      it "should be 2" do
        expect(move_highest_level_to_the_right(1)).to eq(2)
      end
    end

    describe "When is 0" do
      it "should be 3" do
        expect(move_highest_level_to_the_right(0)).to eq(3)
      end
    end

  end

end
