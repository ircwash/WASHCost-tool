class Api::V1::AdvancedController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def show # testing oauth - can remove
    respond_with @report = User.all
  end
end