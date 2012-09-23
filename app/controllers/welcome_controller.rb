class WelcomeController < ApplicationController

  def index
    redirect_to organizations_url
  end

end
