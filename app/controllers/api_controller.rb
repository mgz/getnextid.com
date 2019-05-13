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
    
    def inc_or_create
        if params[:auth].present? && params[:auth] == @counter.password
            Counter.with_advisory_lock('find') do
                @counter = Counter.create!(
                    name: params[:name],
                    created_from_ip_id: Ip.get(request.remote_ip).id,
                    incremented_from_ip_id: Ip.get(request.remote_ip).id
                )
            end
            @counter.inc!
            render plain: @counter.value
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
