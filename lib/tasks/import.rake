require 'fileutils'
require 'csv'

namespace :import do

  desc 'Imports a tsv imdb database in a sqlite database'
  task :to_sqlite, [:file_path] => :environment do |_, args|
    batch_size = 1000
    batch = []
    columns = [:tconst,
               :titleType,
               :primaryTitle,
               :originalTitle,
               :isAdult,
               :startYear,
               :endYear,
               :runtimeMinutes,
               :genres]

    CSV.foreach(args[:file_path], { col_sep: "\t", liberal_parsing: true, quote_char: "\x00"}) do |row|
      puts "Currently inserting row #{$.}"
      batch << row

      if batch.length == batch_size
        Movie.connection
        Movie.import(columns, batch, validate: false)
        batch = []
      end
    end
  end

  desc 'Imports a tsv imdb database to be used as data source'
  task :to_local, [:file_path] do |_, args|
    destination = __dir__ + '/../../db/database.tsv'
    FileUtils.cp(args[:file_path], destination)
  end
end
