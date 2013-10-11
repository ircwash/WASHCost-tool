# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'Seeding...'

puts 'create a test user'
User.find_or_create_by(first_name: 'allan', last_name: 'britto', email: 'test@test.com', password: '12345678')

puts 'Add Advanced::Questionnaire::Questions...'
q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'Country?', section: 'context', numeric_reference: 1)
#q.scheme = Advanced::Questionnaire::Schemes::TextField.new(placeholder: 'placeholder 1', enable_dont_know: true)
#q.save
q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'Region?', section: 'context', numeric_reference: 2)
#q.scheme = Advanced::Questionnaire::Schemes::TextField.new(placeholder: 'placeholder 2', enable_dont_know: true)
#q.save
q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'City/town name?', section: 'context', numeric_reference: 3)
#q.scheme = Advanced::Questionnaire::Schemes::TextField.new(placeholder: 'placeholder 3', enable_dont_know: true)
#q.save
q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'How many people is the water system(s) expected to serve?', section: 'context', numeric_reference: 4)
#q.scheme = Advanced::Questionnaire::Schemes::TextField.new(placeholder: 'placeholder 4', enable_dont_know: true)
#q.save
q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'How many people are actually being served by the water system(s)?', section: 'context', numeric_reference: 5)
#q.scheme = Advanced::Questionnaire::Schemes::TextField.new(placeholder: 'placeholder 5', enable_dont_know: true)
#q.save
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'Description of area type?', section: 'context', numeric_reference: 6)
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'What is the population density of the service area?', section: 'context', numeric_reference: 7)
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'Which of these options best describes how the water service is managed?', section: 'system management', numeric_reference: 8)
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'Who finances the construction of the water system?', section: 'system management', numeric_reference: 9)
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'Who legally owns the water infrastructure?', section: 'system management', numeric_reference: 10)
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'Who safeguards the operation and maintenance of the infrastructure?', section: 'system management', numeric_reference: 11)
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'Who has/will have responsibility for checking and enforcing the standard of water services? ', section: 'system management', numeric_reference: 12)
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'Who covers the cost of rehabilitation when larger repairs are needed?', section: 'system management', numeric_reference: 13)
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'What is the average annual household income in the service area', section: 'system management', numeric_reference: 14)
#q = Advanced::Questionnaire::Question.find_or_create_by(caption: 'What supply system(s) are used to deliver water services? ', section: 'system characteristics', numeric_reference: 15)

puts 'Add Advanced::Water::QuestionOption...'
question_option_labels = ["Don't know", "Rural", "Small town", "Peri-urban", "Urban", "400 + pp/km2", "150 - 399 pp/km2", "<150 pp/km2", "External donor", "Community-based management", "Public sector (local)", "Public sector (national)", "Private sector", "Utility management", "Household management", "Other (define)", "Borehole and handpump", "Mechanised borehole", "Single town system", "Multi-town system", "Small scale rain fed system", "Protected well", "Rural gravity fed system", "Mixed piped system", "Ground water", "Surface water", "Rain water", "Rain water harvesting", "Catchment storage dam", "Sub-surface harvesting (sump)", "River", "Unprotected dug well", "Protected dug well", "Drilled well with mechanised pump", "Drilled well with non-mechanised pump", "Not applicable", "Rope pump", "Hand pump", "No storage", "Reinforced concrete reservoir", "Elevated steel reservoir", "Cistern", "Household storage", "Ferrocement tank", "No treatment", "Boiling", "Household filter", "Household chlorination", "Chlorination in piped system", "Water treatment works", "No power", "Mains electricity", "Windmills", "Solar power systems", "Generator"]
#question_option_labels.each do |label|
#  Advanced::Water::QuestionOption.find_or_create_by(label: label)
#end

#puts 'Add Advanced::Water::QuestionOptionGroup...'
#Advanced::Water::QuestionOption.find_by(label: "")
#Advanced::Water::QuestionOptionGroup.find_or_create_by(name: "area_type").advanced_water_question_options.concat([Advanced::Water::QuestionOption.find_by(label: "Rural"), Advanced::Water::QuestionOption.find_by(label: "Small town"), Advanced::Water::QuestionOption.find_by(label: "Peri-urban"), Advanced::Water::QuestionOption.find_by(label: "Urban"), Advanced::Water::QuestionOption.find_by(label: "Don't know")])
#Advanced::Water::QuestionOptionGroup.find_or_create_by(name: "population_density").advanced_water_question_options.concat([Advanced::Water::QuestionOption.find_by(label: "400 + pp/km2"), Advanced::Water::QuestionOption.find_by(label: "150 - 399 pp/km2"), Advanced::Water::QuestionOption.find_by(label: "<150 pp/km2"), Advanced::Water::QuestionOption.find_by(label: "Don't know")])
#Advanced::Water::QuestionOptionGroup.find_or_create_by(name: "management_type").advanced_water_question_options.concat([Advanced::Water::QuestionOption.find_by(label: "Community-based management"), Advanced::Water::QuestionOption.find_by(label: "Public sector (local)"), Advanced::Water::QuestionOption.find_by(label: "Public sector (national)")])
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "financer").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "owner").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "maintainer").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "auditor").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "rehabilitation_entity").concat()
#Advanced::Water::QuestionOptionGroup.find_or_create_by(label: "delivery_system").concat()

