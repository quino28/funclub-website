class Api::SignInController < ApplicationController
  def sign_in
    data = nil
    member = Members.find_by(email: params[:form][:email])
    if member && member.authenticate(params[:form][:password])
      data = {
        member: member
      }
    end

    render :json => data
  end
end