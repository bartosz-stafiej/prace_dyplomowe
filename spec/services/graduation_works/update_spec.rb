# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GraduationWorks::Update do
  describe '#call' do
    let!(:graduation_work) { create(:graduation_work) }
    let(:updator) { described_class.new(data: input, graduation_work: graduation_work) }
    let(:result) { updator.call }

    context 'when not updating supervisor' do
      let(:input) { { title: 'new title', topic: 'new topic' } }

      before do
        expect(described_class)
          .to receive(:new)
          .with(data: input, graduation_work: graduation_work)
          .and_return(updator)

        expect(updator)
          .to receive(:call)
          .and_return(result)
      end

      it 'updates graduation_work correctly' do
        gd = described_class.new(data: input, graduation_work: graduation_work).call
        expect(gd.title).to eq(input[:title])
      end
    end

    context 'when updating supervisor' do
      let(:valid_input) { { title: 'new title', topic: 'new topic' } }
      let(:supervisor) { create(:employee) }

      context 'when supervisor exists' do
        let(:input) { valid_input.merge(supervisor_email: supervisor.email) }

        before do
          expect(described_class)
            .to receive(:new)
            .with(data: input, graduation_work: graduation_work)
            .and_return(updator)

          expect(updator)
            .to receive(:call)
            .and_return(result)
        end

        it 'updates graduation_work correctly' do
          gd = described_class.new(data: input, graduation_work: graduation_work).call
          expect(gd.supervisor_id).to eq(supervisor.id)
          expect(gd.title).to eq(input[:title])
        end
      end

      context 'when supervisor does not exist' do
        let(:input) { valid_input.merge(supervisor_email: 'invalid@email.com') }

        before do
          expect(described_class)
            .to receive(:new)
            .with(data: input, graduation_work: graduation_work)
            .and_return(updator)

          expect(updator)
            .to receive(:call)
            .and_raise(Controllers::Errors::Api::NotFound)
        end

        it 'raises NotFound api error' do
          expect { described_class.new(data: input, graduation_work: graduation_work).call }
            .to raise_error(Controllers::Errors::Api::NotFound)

          expect(graduation_work.title).not_to eq(input[:title])
        end
      end
    end
  end
end
