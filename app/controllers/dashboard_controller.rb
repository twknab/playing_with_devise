require 'rubygems'
require 'excon'
require 'json'

class DashboardController < ApplicationController
  before_action :authenticate_user

  def index
  end

  # TODO: Break this method up, since it's really doing 2 thigns: fetching the weather AND updating
  def update
    # @threshold = params[:aqi_treshold]
    response = fetch_aqi_data(params[:city], params[:aqi_threshold])
    if response['status'] == 'ok'
      current_user.update(city: params[:city], aqi_threshold: params[:aqi_threshold])
      # TODO: Send back response.data.aqi accessible on template side
      @aqi = response['data']['aqi']
    else
      flash[:alert] = "Location not found, please try another City"
    end
    render :index
  end
  # TODO: Add rescue in case the update fails for some reason, handle error gracefully for user and log?

  private

  def authenticate_user
    unless current_user
      redirect_to root_path
    end
  end

  def fetch_aqi_data(city, aqi_threshold)
    base_url = "https://api.waqi.info/feed".freeze
    uri = "#{base_url}/#{city}/?token=#{ENV['WAQI_TOKEN']}"
    response = Excon.get(uri)
    return JSON.parse(response.body)
  end
end
