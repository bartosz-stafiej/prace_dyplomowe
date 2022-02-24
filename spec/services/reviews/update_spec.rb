# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reviews::Update do
  describe '#call' do
    let!(:review) { create(:review) }
    let(:updator) { described_class.new(data: input, review: review) }
    let(:result) { updator.call }

    context 'when not updating reviewer' do
      let(:input) { { comment: 'new comment' } }

      before do
        expect(described_class)
          .to receive(:new)
          .with(data: input, review: review)
          .and_return(updator)

        expect(updator)
          .to receive(:call)
          .and_return(result)
      end

      it 'updates review correctly' do
        updated_review = described_class.new(data: input, review: review).call
        expect(updated_review.comment).to eq(input[:comment])
      end
    end

    context 'when updating reviewer' do
      let(:valid_input) { { comment: 'new comment' } }
      let(:reviewer) { create(:employee) }

      context 'when reviewer exists' do
        let(:input) { valid_input.merge(reviewer_email: reviewer.email) }

        before do
          expect(described_class)
            .to receive(:new)
            .with(data: input, review: review)
            .and_return(updator)

          expect(updator)
            .to receive(:call)
            .and_return(result)
        end

        it 'updates review correctly' do
          updated_review = described_class.new(data: input, review: review).call
          expect(updated_review.reviewer_id).to eq(reviewer.id)
          expect(updated_review.comment).to eq(input[:comment])
        end
      end

      context 'when reviewer does not exist' do
        let(:input) { valid_input.merge(reviewer_email: 'invalid@email.com') }

        before do
          expect(described_class)
            .to receive(:new)
            .with(data: input, review: review)
            .and_return(updator)

          expect(updator)
            .to receive(:call)
            .and_raise(Controllers::Errors::Api::NotFound)
        end

        it 'raises NotFound api error' do
          expect { described_class.new(data: input, review: review).call }
            .to raise_error(Controllers::Errors::Api::NotFound)

          expect(review.comment).not_to eq(input[:comment])
        end
      end
    end
  end
end
