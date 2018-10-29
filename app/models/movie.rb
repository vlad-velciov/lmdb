class Movie < ApplicationRecord
  include Retrievable

  scope :by_title, ->(title){ where('originalTitle LIKE ?', "%#{title}%") }


  def self.retrieve(title, limit)
    by_title(title)
       .limit(limit)
       .all
  end
end
