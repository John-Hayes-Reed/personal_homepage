# Controller for home pages in the admin namespace.
class Admin::HomeController < ApplicationController
  before_action :authenticate_admin!

  def index; end
end
