require 'spec_helper'

describe "Water Basic Report Saving" do
  context 'when a signed user saves the water basic report' do
    it 'save a new report' do
      basic_water_report = report_data
      visit '/cal/water_basic/report'

    end

    # a more semantic approach to naming the session
    def report_data
      # the notation used in the backend is string instead the symbols, for this reason, the session form is created in
      # this way
      basic_water_session({
                            'country' =>  'BI',
                            'water' =>  1,
                            'population' =>  1200,
                            'capital' =>  59,
                            'recurrent' =>  8,
                            'time' =>  1,
                            'quantity' =>  2,
                            'quality' =>  2,
                            'reliability' =>  2,
                         })
      basic_water_session
    end
  end
end
