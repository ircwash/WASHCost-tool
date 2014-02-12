class UserReport < Report

  embedded_in :user

  validates_presence_of :title

  field :title, :type => String

end
