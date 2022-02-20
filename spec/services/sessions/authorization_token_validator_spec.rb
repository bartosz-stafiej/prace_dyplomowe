# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sessions::AuthorizationTokenValidator do
  describe '#call' do
    let(:authorization_token_validator) do
      instance_double(Sessions::AuthorizationTokenValidator)
    end
    let(:user) { create(:employee) }
    let(:purpose) { :access_token }
    let(:auth_token) { access_token(user) }

    context 'when user have valid authentication_token' do
      context 'when authorization_token is valid' do
        before do
          expect(Sessions::AuthorizationTokenValidator)
            .to receive(:new)
            .with(authorization_token: auth_token, purpose: purpose)
            .and_return(authorization_token_validator)

          expect(authorization_token_validator)
            .to receive(:call)
            .and_return(user)
        end

        it 'returns user' do
          expect(described_class.new(
            authorization_token: auth_token,
            purpose: purpose
          )
            .call)
            .to eq(user)
        end
      end

      context 'when authorization_token is invalid' do
        before do
          expect(Sessions::AuthorizationTokenValidator)
            .to receive(:new)
            .with(authorization_token: auth_token, purpose: purpose)
            .and_return(authorization_token_validator)

          expect(authorization_token_validator)
            .to receive(:call)
            .and_raise(Controllers::Errors::Api::Unauthorized)
        end

        it 'raises Unauthorized api error' do
          expect do
            described_class.new(
              authorization_token: auth_token,
              purpose: purpose
            )
                           .call
          end
            .to raise_error(Controllers::Errors::Api::Unauthorized)
        end
      end
    end

    context 'when user have invalid authentication_token' do
      before do
        user.authentication_token = 'invalid'

        expect(Sessions::AuthorizationTokenValidator)
          .to receive(:new)
          .with(authorization_token: auth_token, purpose: purpose)
          .and_return(authorization_token_validator)

        expect(authorization_token_validator)
          .to receive(:call)
          .and_raise(Controllers::Errors::Api::Unauthorized)
      end

      it 'raises Unauthorized api error' do
        expect do
          described_class.new(
            authorization_token: auth_token,
            purpose: purpose
          )
                         .call
        end
          .to raise_error(Controllers::Errors::Api::Unauthorized)
      end
    end
  end
end
