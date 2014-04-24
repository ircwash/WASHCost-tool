class Api::ExampleController < Api::BaseController
  def index
    render :json=> {:success=>true}
  end
end