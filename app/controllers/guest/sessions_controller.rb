class Guest::SessionsController < ApplicationController
  def create
    guest = Guest.new('Guest', 'guest')
    session[:guest] = true
    flash['alert alert-success'] = "Logged in as #{guest.name}.  To use all features of Knead Recipes you will need to log in."
    redirect_to guest_home_path
  end
end
