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

end
