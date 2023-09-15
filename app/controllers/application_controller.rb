class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # def after_sign_in_path_for(resource)
  #   current_user = User.find(current_user.id)
  #   if current_user.type == 'Seller'
  #      sellers_index_path(current_user)
  #   else
  #      customers_index_path(current_user)
  #   end
  # end
end
