# frozen_string_literal: true

require 'rails_helper'

describe GraduationWorks::SearchByTitleQuery do
  let(:filtered_scope) { query_instance.call }
  let(:query_instance) { described_class.new(scope: scope, search_phrase: search_phrase) }
  let(:search_phrase) { graduation_works.first.title }
  let(:scope) { GraduationWork.all }
  let(:graduation_works) { create_list(:graduation_work, 10) }

  describe '#call' do
    context 'when search_phrase params are valid' do
      before do
        expect(described_class)
          .to receive(:new)
          .with(scope: scope, search_phrase: search_phrase)
          .and_return(query_instance)

        expect(query_instance)
          .to receive(:call)
          .and_return(filtered_scope)
      end

      it 'should return filtered scope' do
        result = described_class.new(scope: scope, search_phrase: search_phrase).call
        expected_result = result.pluck(:title).uniq

        expect(expected_result).to eq([search_phrase])
      end
    end

    context 'when search params are invlaid' do
      before do
        expect(described_class)
          .to receive(:new)
          .with(scope: scope, search_phrase: 'invalid_type')
          .and_return(query_instance)

        expect(query_instance)
          .to receive(:call)
          .and_return(scope)
      end

      it 'should return whole scope' do
        result = described_class.new(scope: scope, search_phrase: 'invalid_type').call

        expect(result).to eq(scope)
      end
    end

    context 'when search params are nil' do
      before do
        expect(described_class)
          .to receive(:new)
          .with(scope: scope, search_phrase: nil)
          .and_return(query_instance)

        expect(query_instance)
          .to receive(:call)
          .and_return(scope)
      end

      it 'should return whole scope' do
        result = described_class.new(scope: scope, search_phrase: nil).call

        expect(result).to eq(scope)
      end
    end
  end
end
