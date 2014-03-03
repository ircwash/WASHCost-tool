class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable

  # Persistence relations
  embeds_many :user_reports

  ## Database authenticatable
  field :first_name,         type: String
  field :last_name,          type: String
  field :country,            type: String, default: "GB"
  field :prefered_language,  type: String, default: I18n.locale
  field :company,            type: String, default: ""
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  validates :email,
    :uniqueness => {:message => :unique_email},
    :presence => {:message => :email_missing}

  validates :password,
    :presence => {:message => :password_missing},
    :length => {:within => 8..128, :too_long => :password_too_long, :too_short => :password_too_short},
    :confirmation => {:message => :password_confirm_mismatch}

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  def name
    if first_name || last_name
      "#{first_name} #{last_name}".split.map(&:capitalize).join(' ')
    else
      email.split('@')[0]
    end
  end
end
