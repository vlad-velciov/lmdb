require 'csv'

module Tsv
  class Database

    def initialize(location)
      @location = location
    end

    # We parse the file line by so that we don't load it all in memory
    def like_title(title, limit = 500)
      found = []
      CSV.foreach(@location, { col_sep: "\t", liberal_parsing: true, quote_char: "\x00" }) do |row|
        return found if found.length >= limit
        if row[3].downcase=~ /#{title.downcase}/
          found << Tsv::Movie.new(*row)
        end
      end

      found
    rescue CSV::MalformedCSVError
      return []
    end
  end
end
