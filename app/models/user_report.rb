class UserReport < Report

  embedded_in :user

  # validates_presence_of :title

  field :title, :type => String

  validates :title,
    :uniqueness => {:message => :unique_report},
    :presence => {:message => :report_title_missing}

end
