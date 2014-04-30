class ApplicationsController < Doorkeeper::ApplicationsController
    #layout 'doorkeeper/admin'
    #respond_to :html
    respond_to :json

    before_filter :authenticate_admin!
    before_filter :set_application, :only => [:show, :edit, :update, :destroy]

    # This controller exists if we want to allow open access to register apps
    def index
      render json: Doorkeeper::Application.all
    end

end