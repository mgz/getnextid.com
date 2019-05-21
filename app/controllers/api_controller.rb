class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def show
        if (@counter = Counter.find_by_name(params[:name]))
            render plain: @counter.value
        else
            render plain: "No such counter: #{params[:name]}", status: 404
        end
    end
    
    def inc_or_create
        unless (@counter = Counter.find_by_name(params[:name]))
            Counter.with_advisory_lock('find') do
                @counter = Counter.create!(
                    name: params[:name],
                    created_from_ip_id: Ip.get(request.remote_ip).id,
                    incremented_from_ip_id: Ip.get(request.remote_ip).id
                )
            end
        end
        @counter.inc!
        render plain: @counter.value
    end
end
