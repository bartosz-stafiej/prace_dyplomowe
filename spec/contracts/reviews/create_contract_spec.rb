require 'rails_helper'

RSpec.describe Reviews::CreateContract do
    describe '#call' do
        let(:create_contract) { Reviews::CreateContract.new }
        let(:results) { create_contract.call(params) }
    
        context 'when params are invalid' do
            context 'when params are blank' do
                let(:params) { {} }
                let(:expected_message) do
                {
                    grade: ['is missing'],
                    comment: ['is missing'],
                    reviewer_email: ['is missing'],
                    date_of_issue: ['is missing']
                }
                end
        
                it 'returns a failure' do
                    expect(described_class.new.call(params).failure?).to eq true
                end
        
                it 'returns expected messages' do
                    expect(described_class.new.call(params).errors.to_h).to eq(expected_message)
                end
            end
        
            context 'when reviewer does not exist' do
                let(:params) { attributes_for(:review).merge(reviewer_email: 'not@exist.com') }
        
                let(:expected_message) do
                    {
                        reviewer_email: ["Employee with email #{params[:reviewer_email]} does not exist"]
                    }
                end
        
                it 'returns a failure' do
                    expect(described_class.new.call(params).failure?).to eq true
                end
        
                it 'returns expected messages' do
                    expect(described_class.new.call(params).errors.to_h).to eq(expected_message)
                end
            end
        
            context 'when reviewer email is in invalid format' do
                let(:params) { attributes_for(:review).merge(reviewer_email: 'ivalid') }

                let(:expected_message) do
                    {
                        reviewer_email: ["is in invalid format"]
                    }
                end
        
                it 'returns a failure' do
                    expect(described_class.new.call(params).failure?).to eq true
                end
        
                it 'returns expected messages' do
                    expect(described_class.new.call(params).errors.to_h).to eq(expected_message)
                end
            end
            
                
            context 'when date of issue is after present day' do
                let(:params) do
                    attributes_for(:review).merge(
                        reviewer_email: reviewer.email,
                        date_of_issue: (Time.now + 1.month).to_datetime
                    )
                end

                let(:reviewer) { create(:employee) }

                let(:expected_message) do
                    {
                        date_of_issue: ["must be before present day"]
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
            let(:params) { attributes_for(:review).merge(reviewer_email: reviewer.email) }
            let(:reviewer) { create(:employee) }
        
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