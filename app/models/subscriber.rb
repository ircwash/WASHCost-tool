class Subscriber
  include Mongoid::Document

  validates_presence_of :email
  validates_format_of :email, with: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  field :email
end
