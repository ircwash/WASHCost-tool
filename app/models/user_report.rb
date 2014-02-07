class UserReport < Report

  embedded_in :user

  validates_presence_of :title, :level, :type

  field :title, :type => String

end
