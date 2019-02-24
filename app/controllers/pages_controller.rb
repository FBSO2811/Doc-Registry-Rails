class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:home]


  def home
    if current_user
      @url = request.original_url
      @account_metamask = @url[-42..-1]
      @user_id = current_user.id
      user = User.find_by(id: @user_id)
      user.update(account_metamask: @account_metamask)
    end
  end
end
