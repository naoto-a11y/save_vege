class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    farmer_farmers_mypage_path
  end
end
