class MovieRetrievalStrategy
  TSV = :accurate
  SQL = :fast

  def self.get(type)
    if type == SQL
      return Movie
    elsif type == TSV
      return Tsv::Repo
    end

    Movie
  end
end
