class UsersController < ApplicationController
  before_filter :authorise_admin, only: :create

  def create
    # admins only
  end

  private

  def authorise_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: 'Admins only!'
  end
end
