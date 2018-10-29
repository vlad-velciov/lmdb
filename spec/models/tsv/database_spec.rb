require 'rails_helper'

describe Tsv::Database do
  let(:fixtures_directory) { __dir__ + '/../../fixtures/' }
  let(:first_1000_csv) { fixtures_directory + 'title.basics.first1000.tsv' }
  let(:quoted_entry_tsv) { fixtures_directory + 'quoted_title.tsv' }
  let(:hashtag_title_csv) { fixtures_directory + 'hashtag_title.tsv' }
  let(:malformed_row_tsv) { fixtures_directory + 'malformed_row.tsv' }

  it 'initializes the object with a location' do
    expect(Tsv::Database.new('some_location')).not_to be_nil
  end

  it 'get the first movie from a simple list' do
    database = Tsv::Database.new(first_1000_csv)

    movies = database.like_title 'Carmencita'
    expect(movies[0].originalTitle).to eq 'Carmencita'
  end

  it 'gets a movie with a double quote inside its name' do
    database = Tsv::Database.new(quoted_entry_tsv)

    movies = database.like_title 'Mujeres'
    expect(movies.length).to eq(1)
    expect(movies[0].originalTitle).to eq 'Mujeres al borde de un ataque de "nervios"'
  end

  it 'gets a movie regardless of the capitalization of letters' do
    database = Tsv::Database.new(quoted_entry_tsv)

    movies = database.like_title 'mujeres'
    expect(movies.length).to eq(1)
    expect(movies[0].originalTitle).to eq 'Mujeres al borde de un ataque de "nervios"'
  end

  it 'can find a movie with a hashtag in the middle of its name' do
    database = Tsv::Database.new(hashtag_title_csv)

    movies = database.like_title 'episode'
    expect(movies.length).to eq(1)
    expect(movies[0].originalTitle).to eq 'Episode #1.41'
  end

  it 'returns a empty array if a CsvMalformedError was thrown' do
    allow(CSV).to receive(:foreach).and_raise CSV::MalformedCSVError

    database = Tsv::Database.new(hashtag_title_csv)

    expect(database.like_title('episode')).to eq([])
  end

  it 'returns a malformed row' do
    database = Tsv::Database.new(malformed_row_tsv)

    movies = database.like_title 'Muroe High and Machido High'
    expect(movies.length).to eq(1)
    expect(movies[0].originalTitle).to eq 'Muroe High and Machido High'
  end
end
