require 'spec_helper'


describe QuestionnaireController do
  it "accepts simple calculator parameters" do
    post :create, basic_params
  end


  def basic_params
    {
        questionnaire:
         {
             calculator:
              {
                  country: 1,
                  region: 'cauca',
                  town: 'popayan',
                  system_capacity: 100,
                  system_usage: 50,
                  area_type: 0,
                  population_density: 0,
                  management_type: 0,
                  financer: 0,
                  owner: 0,
                  maintainer: 0,
                  auditor: 0,
                  rehabilitation_entity_id: 0,
                  average_annual_household_income: 1000000,
                  water_delivery_system: 0,
              }
         }
    }
  end
end
