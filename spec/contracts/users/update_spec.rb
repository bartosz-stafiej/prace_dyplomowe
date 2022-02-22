# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::UpdateContract do
  describe '#call' do
    let(:create_contract) { Users::UpdateContract.new }
    let(:results) { create_contract.call(params) }

    context 'when params are invalid' do
      context 'when params are blank' do
        let(:params) { {} }
        let(:expected_message) { {} }

        it 'returns a success' do
          expect(described_class.new.call(params).failure?).to eq false
        end

        it 'returns expected messages' do
          expect(described_class.new.call(params).errors.to_h).to eq(expected_message)
        end
      end

      context 'when email is in invalid format' do
        let(:params) { { email: 'invalid' } }
        let(:expected_message) do
          {
            email: ['is in invalid format']
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
      let(:params) { attributes_for(:employee).slice(:email, :first_name, :last_name) }
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
