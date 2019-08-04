class CountersController < ApplicationController
  
  def index
    @page_title = "GetNextId.com - global counters"
  end
  
  def new
    @page_title = "Creating new counter"
    @counter = Counter.new(
      value: 1
    )
  end
  
  def create
    @counter = Counter.new(counter_params)
    @counter.name.strip!
    @counter.created_from_ip = @counter.incremented_from_ip = Ip.get(request.remote_ip)
    if @counter.save
      session[:my_last_counter_id] = @counter.hashid
      redirect_to @counter.get_url + '/info'
    else
      render action: 'new'
    end
  end
  
  def show
    @counter = Counter.find_by_name(params[:name])
    @counter_is_my = @counter.hashid == session[:my_last_counter_id]
    
    @counter_password = @counter_is_my ? @counter.password : 'YOUR_PASSWORD'
  end
  
  
  private
  
  def counter_params
    params.require(:counter).permit(:name, :value, :password, :read_password)
  end
end
