class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Войдите или Зарегистрируйтесь."

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('question_button', partial: 'devise/sessions/form')
      end
      format.html
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
