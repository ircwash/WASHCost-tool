class Ability
  include CanCan::Ability
  include Rails.application.routes.url_helpers

  attr_accessor :permission_denied

  def initialize(user)
    user ||= User.new

    if user.new_record?
      can :manage, [Basic::WaterController, Basic::SanitationController]

      cannot :manage, [ DashboardController, Advanced::WaterController, Advanced::SanitationController ] do |controller|
        @permission_denied = {}
        @permission_denied[:location] = new_user_session_path( I18n.locale )
        @permission_denied[:message] = 'test message'
        @permission_denied[:output_from] = 'http'
        true
      end
    else
      can :manage, :all
    end
  end
end
