# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def me?
    params[:me_scope] == true
  end
end
