# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::GraduationWorksController, type: :request do
  let!(:graduation_works) { create_list(:graduation_work, 10) }
  let!(:scope) { GraduationWork.all }

  describe 'GET /graduation_works' do
    context 'without search params' do
      before { get '/api/v1/graduation_works' }
      it 'should return all graduation works' do
        expect(json_response['graduation_works'].length).to eq(10)
      end

      it 'should return status 200' do
        expect(response.status).to eq 200
      end
    end

    context 'with search params' do
      before { get '/api/v1/graduation_works', params: { search_phrase: graduation_works.first.title } }
      it 'should return filtered graduation works' do
        expect(json_response['graduation_works'].length).to be >= 1
        expect(json_response['graduation_works'].length).to be < 10
        expect(json_response['graduation_works'].map { |gd| gd['id'] }).to include(graduation_works.first.id)
      end

      it 'should return status 200' do
        expect(response.status).to eq 200
      end
    end
  end
end
