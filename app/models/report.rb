class Report
  include Mongoid::Document
  include Mongoid::Timestamps

  # relations
  embedded_in :user

  # validations
  validates_presence_of :title

  field :title, :type => String
  field :level, :type => String
  field :type,  :type => String
  field :questionnaire,  :type => Hash, :default => {}

end
