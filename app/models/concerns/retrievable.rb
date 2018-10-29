module Retrievable extend ActiveSupport::Concern

  class_methods do
    def retrieve(title, limit)
      raise NotImplementedError
    end
  end
end
