class Api::V1::BaseController < ApplicationController
  include Api::V1::ExceptionHandler

  skip_before_action :verify_authenticity_token
end
