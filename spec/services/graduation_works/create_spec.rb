# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GraduationWorks::Create do
  describe '#call' do
    let!(:graduation_work) { create(:graduation_work) }
    let(:creator) { described_class.new(data: input) }
    let(:result) { creator.call }

    let(:valid_input) do
      supervisor = create(:employee)
      stage_of_study = create(:stage_of_study)

      attributes_for(:graduation_work)
        .merge(
          supervisor_email: supervisor.email,
          stage_of_study_id: stage_of_study.id
        )
    end

    context 'when valid input' do
      let(:input) { valid_input }

      before do
        expect(described_class)
          .to receive(:new)
          .with(data: input)
          .and_return(creator)

        expect(creator)
          .to receive(:call)
          .and_return(result)
      end

      it 'creates graduation_work' do
        graduation_work = described_class.new(data: input).call
        expect(graduation_work.id).not_to be_nil
      end
    end

    context 'when invalid input' do
      context 'when supervisor does not exists' do
        let(:input) { valid_input.except(:supervisor_email) }

        before do
          expect(described_class)
            .to receive(:new)
            .with(data: input)
            .and_return(creator)

          expect(creator)
            .to receive(:call)
            .and_raise(Controllers::Errors::Api::NotFound)
        end

        it 'raise NotFound api error' do
          expect { described_class.new(data: input).call }.to raise_error(Controllers::Errors::Api::NotFound)
        end
      end
    end
  end
end
