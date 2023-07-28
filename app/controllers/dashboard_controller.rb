require 'rubygems'
require 'excon'
require 'json'

class DashboardController < ApplicationController
  before_action :authenticate_user

  def index
    user = User.find(current_user.id)
    @threshold = user.aqi_threshold
    if user.city && user.aqi_threshold
      response = fetch_aqi_data(user.city, user.aqi_threshold)
      if response['status'] == 'ok'
        @aqi = response['data']['aqi']
      end
    end
  end

  def update
    current_user.update(city: params[:city], aqi_threshold: params[:aqi_threshold])
    redirect_to dashboard_path
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
