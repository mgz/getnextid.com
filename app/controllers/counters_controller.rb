class CountersController < ApplicationController
    
    def index
        @page_title = "IDS"
    end
    
    def new
        @page_title = "Creating new counter"
        @counter = Counter.new
    end
end
