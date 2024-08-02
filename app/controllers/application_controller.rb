class ApplicationController < ActionController::Base
  include SessionsHelper
  include ProductsHelper
  include Pagy::Backend
end
