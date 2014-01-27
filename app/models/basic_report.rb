class BasicReport
  include Mongoid::Document
  include Mongoid::Timestamps

  # relations
  embedded_in :user

  # validations
  validates_presence_of :title

  field :title,     type: String
  field :tool_name, type: String
  field :form,      type: Hash, default: {}

  def percent_completed
    pages_number = (tool_name=='water' ? 9 : 11)
    pages_completed = form["pages_completed"] || 0
    ((pages_completed.to_f/pages_number.to_f) * 100).to_i
  end

end
