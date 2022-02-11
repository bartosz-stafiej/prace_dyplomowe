require 'rails_helper'

RSpec.describe Sessions::UpdateAuthenticationToken do
    describe '#call' do
        let!(:user_auth_token) { user.authentication_token }
        let(:user) { create(:employee) }

        it 'should updates user authentication token' do
            expect { described_class
                .new(user: user).call
            }.to change { user.authentication_token }

            expect(user.authentication_token).not_to eq(user_auth_token)
        end
    end 
end