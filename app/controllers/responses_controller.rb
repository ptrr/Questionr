class ResponsesController < ApplicationController
  def index

  end

  def new
    @form = Form.find_by_id(params[:form_id])

  end
end