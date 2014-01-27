class Advanced::WaterController < ApplicationController

  layout "tool"

  authorize_resource :class => Advanced::WaterController


  def context

  end

end
