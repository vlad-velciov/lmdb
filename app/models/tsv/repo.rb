module Tsv
  class Repo
    include Retrievable

    def self.retrieve(title, limit)
      database = Database.new(Rails.application.config.tsv_database_location)
      database.like_title(title, limit)
    end
  end
end
