module Api::V1::ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      render json: { errors: { message: I18n.t('exceptions.record_not_found') } }, status: :not_found
    end
  end
end
