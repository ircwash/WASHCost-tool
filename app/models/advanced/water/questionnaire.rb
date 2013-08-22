class Advanced::Water::Questionnaire
  include Mongoid::Document

  has_many :questions, class_name: "Advanced::Water::Question"

  field :title,                             type: String
  field :country,                           type: String
  field :region,                            type: String
  field :town,                              type: String
  field :system_capacity,                   type: Integer
  field :system_usage,                      type: Integer
  field :area_type,                         type: Integer
  field :population_density,                type: Integer
  field :management_type,                   type: Integer
  field :financer,                          type: Integer
  field :owner,                             type: Integer
  field :maintainer,                        type: Integer
  field :auditor,                           type: Integer
  field :rehabilitation_entity,             type: Integer
  field :average_annual_household_income,   type: Integer
  field :delivery_system,                   type: Integer
end
