# frozen_string_literal: true

class RaportsController < ApplicationController
  include Pagy::Backend

  def index
    @search_params = permited_params
    scope = Raports::ScopeQuery.new(search_params: @search_params).call

    @pagy, @graduation_works = pagy(scope, items: 20)
  end

  def new; end

  def create
    redirect_to raports_path params: permited_params
  end

  def generate_csv
    scope = Raports::ScopeQuery.new(search_params: csv_params).call

    csv_data = GraduationWork.generate_csv(scope)
    send_data csv_data, filename: "Raport-#{Date.today}.csv", disposition: :attachment
  end

  private

  def permited_params
    params.permit(:grade, :faculty, :date_from, :date_to, :evaluator, :supervisor, :field_of_study, :key_word).to_unsafe_h.reject { |_k, v| v.empty? }
  end

  def csv_params
    params.require(:search_params).permit!.to_unsafe_h
  end
end
