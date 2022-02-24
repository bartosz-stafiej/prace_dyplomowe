# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reviews::Create do
  describe '#call' do
    let!(:graduation_work) { create(:graduation_work) }
    let(:creator) { described_class.new(data: input, graduation_work: graduation_work) }
    let(:result) { creator.call }

    let(:valid_input) do
      reviewer = create(:employee)

      attributes_for(:review)
        .merge(reviewer_email: reviewer.email)
    end

    context 'when valid input' do
      let(:input) { valid_input }

      before do
        expect(described_class)
          .to receive(:new)
          .with(data: input, graduation_work: graduation_work)
          .and_return(creator)

        expect(creator)
          .to receive(:call)
          .and_return(result)
      end

      it 'creates review' do
        review = described_class.new(data: input, graduation_work: graduation_work).call
        expect(review.id).not_to be_nil
      end
    end

    context 'when invalid input' do
      context 'when reviewer does not exists' do
        let(:input) { valid_input.except(:reviewer_email) }

        before do
          expect(described_class)
            .to receive(:new)
            .with(data: input, graduation_work: graduation_work)
            .and_return(creator)

          expect(creator)
            .to receive(:call)
            .and_raise(Controllers::Errors::Api::NotFound)
        end

        it 'raise NotFound api error' do
          expect { described_class.new(data: input, graduation_work: graduation_work).call }
            .to raise_error(Controllers::Errors::Api::NotFound)
        end
      end
    end
  end
end
