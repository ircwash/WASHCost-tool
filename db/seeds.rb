# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'Seeding...'

puts 'Add Advanced::Water::Questions...'
Advanced::Water::Question.first_or_create(text: "Country?", section: "context", questionnaire_field: "country")
Advanced::Water::Question.find_or_create_by(text: "Region?", section: "context", questionnaire_field: "region")
Advanced::Water::Question.find_or_create_by(text: "City/town name?", section: "context", questionnaire_field: "town")
Advanced::Water::Question.find_or_create_by(text: "How many people is the water system(s) expected to serve?", section: "context", questionnaire_field: "system_capacity")
Advanced::Water::Question.find_or_create_by(text: "How many people are actually being served by the water system(s)?", section: "context", questionnaire_field: "system_usage")
Advanced::Water::Question.find_or_create_by(text: "Description of area type?", section: "context", questionnaire_field: "area_type")
Advanced::Water::Question.find_or_create_by(text: "What is the population density of the service area?", section: "context", questionnaire_field: "population_density")
Advanced::Water::Question.find_or_create_by(text: "Which of these options best describes how the water service is managed?", section: "system management", questionnaire_field: "management_type")
Advanced::Water::Question.find_or_create_by(text: "Who finances the construction of the water system?", section: "system management", questionnaire_field: "financer")
Advanced::Water::Question.find_or_create_by(text: "Who legally owns the water infrastructure?", section: "system management", questionnaire_field: "owner")
Advanced::Water::Question.find_or_create_by(text: "Who safeguards the operation and maintenance of the infrastructure?", section: "system management", questionnaire_field: "maintainer")
Advanced::Water::Question.find_or_create_by(text: "Who has/will have responsibility for checking and enforcing the standard of water services? ", section: "system management", questionnaire_field: "auditor")
Advanced::Water::Question.find_or_create_by(text: "Who covers the cost of rehabilitation when larger repairs are needed?", section: "system management", questionnaire_field: "rehabilitation_entity")
Advanced::Water::Question.find_or_create_by(text: "What is the average annual household income in the service area", section: "system management", questionnaire_field: "average_annual_household_income")
Advanced::Water::Question.find_or_create_by(text: "What supply system(s) are used to deliver water services? ", section: "system characteristics", questionnaire_field: "delivery_system")

puts 'Add Advanced::Water::QuestionOption...'
question_option_labels = ["Don't know", "Rural", "Small town", "Peri-urban", "Urban", "400 + pp/km2", "150 - 399 pp/km2", "<150 pp/km2", "External donor", "Community-based management", "Public sector (local)", "Public sector (national)", "Private sector", "Utility management", "Household management", "Other (define)", "Borehole and handpump", "Mechanised borehole", "Single town system", "Multi-town system", "Small scale rain fed system", "Protected well", "Rural gravity fed system", "Mixed piped system", "Ground water", "Surface water", "Rain water", "Rain water harvesting", "Catchment storage dam", "Sub-surface harvesting (sump)", "River", "Unprotected dug well", "Protected dug well", "Drilled well with mechanised pump", "Drilled well with non-mechanised pump", "Not applicable", "Rope pump", "Hand pump", "No storage", "Reinforced concrete reservoir", "Elevated steel reservoir", "Cistern", "Household storage", "Ferrocement tank", "No treatment", "Boiling", "Household filter", "Household chlorination", "Chlorination in piped system", "Water treatment works", "No power", "Mains electricity", "Windmills", "Solar power systems", "Generator"]
question_option_labels.each do |label|
  Advanced::Water::QuestionOption.find_or_create_by(label: label)
end

puts 'Add Advanced::Water::QuestionOptionGroup...'
#Advanced::Water::QuestionOption.find_by(label: "")
Advanced::Water::QuestionOptionGroup.find_or_create_by(name: "area_type").advanced_water_question_options.concat([Advanced::Water::QuestionOption.find_by(label: "Rural"), Advanced::Water::QuestionOption.find_by(label: "Small town"), Advanced::Water::QuestionOption.find_by(label: "Peri-urban"), Advanced::Water::QuestionOption.find_by(label: "Urban"), Advanced::Water::QuestionOption.find_by(label: "Don't know")])
Advanced::Water::QuestionOptionGroup.find_or_create_by(name: "population_density").advanced_water_question_options.concat([Advanced::Water::QuestionOption.find_by(label: "400 + pp/km2"), Advanced::Water::QuestionOption.find_by(label: "150 - 399 pp/km2"), Advanced::Water::QuestionOption.find_by(label: "<150 pp/km2"), Advanced::Water::QuestionOption.find_by(label: "Don't know")])
Advanced::Water::QuestionOptionGroup.find_or_create_by(name: "management_type").advanced_water_question_options.concat([Advanced::Water::QuestionOption.find_by(label: "Community-based management"), Advanced::Water::QuestionOption.find_by(label: "Public sector (local)"), Advanced::Water::QuestionOption.find_by(label: "Public sector (national)")])
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "financer").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "owner").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "maintainer").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "auditor").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "rehabilitation_entity").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "delivery_system").concat()

