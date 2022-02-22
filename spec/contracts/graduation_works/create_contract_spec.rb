# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GraduationWorks::CreateContract do
  describe '#call' do
    let(:create_contract) { GraduationWorks::CreateContract.new }
    let(:results) { create_contract.call(params) }

    context 'when params are invalid' do
      context 'when params are blank' do
        let(:params) { {} }
        let(:expected_message) do
          {
            date_of_submission: ['is missing'],
            stage_of_study_id: ['is missing'],
            supervisor_email: ['is missing'],
            title: ['is missing'],
            topic: ['is missing']
          }
        end

        it 'returns a failure' do
          expect(described_class.new.call(params).failure?).to eq true
        end

        it 'returns expected messages' do
          expect(described_class.new.call(params).errors.to_h).to eq(expected_message)
        end
      end

      context 'when supervisor does not exist is in invalid format' do
        let(:params) do
          attributes_for(:graduation_work).merge(
            stage_of_study_id: stage_of_study.id,
            supervisor_email: 'invalid@email.com',
            date_of_submission: Time.zone.now.to_datetime
          )
        end
        let(:stage_of_study) { create(:stage_of_study) }

        let(:expected_message) do
          {
            supervisor_email: ["Employee with email #{params[:supervisor_email]} does not exist"]
          }
        end

        it 'returns a failure' do
          expect(described_class.new.call(params).failure?).to eq true
        end

        it 'returns expected messages' do
          expect(described_class.new.call(params).errors.to_h).to eq(expected_message)
        end
      end

      context 'when stage_of_study does not exist is in invalid format' do
        let(:params) do
          attributes_for(:graduation_work).merge(
            stage_of_study_id: 1,
            supervisor_email: supervisor.email,
            date_of_submission: Time.zone.now.to_datetime
          )
        end
        let(:supervisor) { create(:employee) }

        let(:expected_message) do
          {
            stage_of_study_id: ["StageOfStudy with id #{params[:stage_of_study_id]} does not exist"]
          }
        end

        it 'returns a failure' do
          expect(described_class.new.call(params).failure?).to eq true
        end

        it 'returns expected messages' do
          expect(described_class.new.call(params).errors.to_h).to eq(expected_message)
        end
      end

      context 'when date_of_submission is after present day' do
        let(:params) do
          attributes_for(:graduation_work).merge(
            stage_of_study_id: stage_of_study.id,
            supervisor_email: supervisor.email,
            date_of_submission: Time.zone.now.to_datetime + 1.month
          )
        end

        let(:stage_of_study) { create(:stage_of_study) }
        let(:supervisor) { create(:employee) }

        let(:expected_message) do
          {
            date_of_submission: ['must be before present day']
          }
        end

        it 'returns a failure' do
          expect(described_class.new.call(params).failure?).to eq true
        end

        it 'returns expected messages' do
          expect(described_class.new.call(params).errors.to_h).to eq(expected_message)
        end
      end
    end

    context 'when params are valid' do
      let(:params) do
        attributes_for(:graduation_work).merge(
          stage_of_study_id: stage_of_study.id,
          supervisor_email: supervisor.email,
          date_of_submission: Time.zone.now.to_datetime
        )
      end
      let(:stage_of_study) { create(:stage_of_study) }
      let(:supervisor) { create(:employee) }

      let(:expected_message) { {} }

      it 'returns a success' do
        expect(described_class.new.call(params).failure?).to eq false
      end

      it 'returns expected messages' do
        expect(described_class.new.call(params).errors.to_h).to eq(expected_message)
      end
    end
  end
end
