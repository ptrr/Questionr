require 'statsd'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :gief_stats_pls

  def gief_stats_pls
    @statsd = Statsd::Client.new('vps1820.directvps.nl',8125)

  end
end
