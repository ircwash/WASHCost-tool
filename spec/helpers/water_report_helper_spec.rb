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
end
