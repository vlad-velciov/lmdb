require 'rails_helper'

describe MoviesController do
  before(:each) do
    allow(Movie).to receive(:all).and_return mock_response
  end

  let(:movie) { {:tconst => 'asdasd',
                 :titleType => 'asdasd',
                 :primaryTitle => 'asdasd',
                 :originalTitle => 'asdasd',
                 :isAdult => 'asdasd',
                 :startYear => 'asdasd',
                 :endYear => 'asdasd',
                 :runtimeMinutes => 'asdasd',
                 :genres => 'asdasd'} }
  let(:mock_response) { [movie, movie, movie, movie, movie]}

  describe '#index' do
    it 'returns an empty array if no title is given' do
      get :index, params: { title: ''}
      expect(response.body).to eq('[]')
    end

    it 'returns 5 movies if it finds them' do
      allow(Movie).to receive(:retrieve).and_return mock_response
      get :index, params: { title: 'asdasd', strategy: 'fast' }

      expect(response.body).to eq(mock_response.to_json)
    end
  end
end
