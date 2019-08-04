class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_if_counter_exists
  
  def show
    if params[:auth].present? && params[:auth].in?([@counter.password, @counter.read_password])
      render plain: @counter.value
    else
      render plain: "Invalid auth. Usage:\ncurl \"#{request.base_url}/counter/#{@counter.name}?auth=YOUR_PASSWORD\"", status: 403
    end
  
  end
  
  def inc
    if params[:auth].present? && params[:auth] == @counter.password
      if @counter.value < MAX_VALUE
        @counter.inc!
        render plain: @counter.value
      else
        render plain: "Error: MAX_VALUE is #{MAX_VALUE}", status: 500
      end
    else
      render plain: "Invalid auth. Usage:\ncurl -X POST \"#{request.base_url}/counter/#{@counter.name}?auth=YOUR_PASSWORD\"", status: 403
    end
  end
  
  
  private
  
  def check_if_counter_exists
    unless (@counter = Counter.find_by_name(params[:name]))
      render plain: "No such counter: #{params[:name]}", status: 404
      return false
    end
  end
end
