# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sessions::Authenticator do
  describe '#call' do
    let(:authenticator) { described_class.new(email: email, password: password) }
    let(:result) { authenticator.call }

    context 'when user exists' do
      let(:user) { create(:employee, password: password, password_confirmation: password) }

      context 'when user is authenticated correctlly' do
        before do
          expect(Sessions::Authenticator)
            .to receive(:new)
            .with(email: email, password: password)
            .and_return(authenticator)

          expect(authenticator)
            .to receive(:call)
            .and_return(result)
        end

        let(:email) { user.email }
        let(:password) { 'password' }

        it 'returns user' do
          expect(described_class.new(email: email, password: password)
              .call)
            .to eq(user)
        end
      end

      context 'when email or password are blank' do
        before do
          expect(Sessions::Authenticator)
            .to receive(:new)
            .with(email: email, password: password)
            .and_return(authenticator)

          expect(authenticator)
            .to receive(:call)
            .and_raise(Controllers::Errors::Api::Unauthorized)
        end

        let(:email) { nil }
        let(:password) { 'password' }

        it 'raise Unauthorized api error' do
          expect do
            described_class.new(email: email, password: password)
                           .call
          end
            .to raise_error(Controllers::Errors::Api::Unauthorized)
        end
      end
    end

    context 'when user does not exist' do
      let(:email) { 'does-not-exist' }
      let(:password) { 'password' }

      before do
        expect(Sessions::Authenticator)
          .to receive(:new)
          .with(email: email, password: password)
          .and_return(authenticator)

        expect(authenticator)
          .to receive(:call)
          .and_raise(Controllers::Errors::Api::Unauthorized)
      end

      it 'raise Unauthorized api error' do
        expect do
          described_class.new(email: email, password: password)
                         .call
        end
          .to raise_error(Controllers::Errors::Api::Unauthorized)
      end
    end
  end
end
