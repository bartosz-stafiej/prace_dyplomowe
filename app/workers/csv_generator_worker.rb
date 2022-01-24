# frozen_string_literal: true

class CsvGeneratorWorker
  include Sidekiq::Worker

  def perform(scope)
    GraduationWork.to_csv(scope)
  end
end
