class SubscribersController < ApplicationController
  
  def create
    @subscriber = Subscriber.new(params[:subscriber])
    respond_to do |format|
      if @subscriber.save
        format.html { redirect_to request.referer, alert: 'Subscription was successfully created.' }
        format.json { render json: @subscriber, status: :created, location: @subscriber }
        format.js
      else
        puts @subscriber.errors.full_messages.first
        format.html { render :nothing => true }
        format.js
      end
    end
  end
end
