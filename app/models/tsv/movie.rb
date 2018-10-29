module Tsv

  Movie = Struct.new(:tconst,
                     :titleType,
                     :primaryTitle,
                     :originalTitle,
                     :isAdult,
                     :startYear,
                     :endYear,
                     :runtimeMinutes,
                     :genres)
end
