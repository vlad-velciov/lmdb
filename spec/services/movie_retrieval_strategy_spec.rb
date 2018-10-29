require 'rails_helper'

describe MovieRetrievalStrategy do
  it 'retrieves a Movie class by default' do
    expect(subject.class.get('')).to eq Movie
  end

  it 'retrieves a Movie class for a fast strategy' do
    expect(subject.class.get(:fast)).to eq Movie
  end

  it 'retrieves a Tsv::Repo class for a accurate strategy' do
    expect(subject.class.get(:accurate)).to eq Tsv::Repo
  end
end
