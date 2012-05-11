require 'statsd'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :gief_stats_pls
  before_filter :pass_form_to_api

  def gief_stats_pls
    @statsd = Statsd::Client.new('vps1820.directvps.nl',8125)
  end


  def pass_form_to_api
    @form_id = params[:id]
  end
end
