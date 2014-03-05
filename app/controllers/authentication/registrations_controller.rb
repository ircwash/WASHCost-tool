class Authentication::RegistrationsController < Devise::RegistrationsController

  include Rails.application.routes.url_helpers

  layout "general"

  def update
    @user = User.find(current_user.id)

    # prevent updating email address
    params[:user][:email] = @user.email
    I18n.locale = params[:user][:prefered_language]

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user, I18n.locale)
    else
      render "edit"
    end

  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
      !params[:user][:password].blank?
  end

  protected

  def after_update_path_for(resource)
    "/" + current_user.prefered_language + dashboard_index_path
  end

end
