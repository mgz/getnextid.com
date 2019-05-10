class Counter < ApplicationRecord
    def inc!
        return self.increment!(:value).value
    end
end
