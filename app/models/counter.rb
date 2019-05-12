class Counter < ApplicationRecord
    before_create :init_password
    
    def inc!
        return self.increment!(:value).value
    end
    
    
    
    
    
    
    
    private
    def init_password
        self.password ||= SecureRandom.hex
    end
end
