# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
