class DirectoryController < ApplicationController
  def index
    @members = User.all # Assuming members are stored in the User model
  end
end
