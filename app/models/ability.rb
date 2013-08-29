class Ability
  include CanCan::Ability
  include Rails.application.routes.url_helpers

  attr_accessor :permission_denied

  def initialize(user)
    user ||= User.new
    #can :manage, [WaterBasicController, SanitationBasicController] if user.present?
    if user.new_record?
      can :manage, [WaterBasicController, SanitationBasicController]
      cannot :save, Basic::ReportsController do |kontroller|
        @permission_denied = {}
        @permission_denied[:url] = new_user_session_path
        @permission_denied[:message] = 'test message'
        @permission_denied[:http_request] = 'xhr'
        true
      end
    else
      can :manage, :all
    end
  end
end
