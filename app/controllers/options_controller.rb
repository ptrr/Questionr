class OptionsController < ApplicationController
  respond_to :json

  def index
    respond_with Option.where(:question_id => params[:question_id])
  end

  def show
    respond_with Option.find(params[:id])
  end

  def create
    @option = Option.new
    @question = Question.find_by_id(params[:question_id])
    @option.option_label = params[:option_label]
    @option.option_value = params[:option_value]
    @option.question_id = params[:question_id]
    @option.option_type = params[:option_type]
    @option.order = params[:order]
    @option.save
    respond_with Form.find(params[:form_id]), @question, @option
    #respond_with Option.create(params[:option], question_id: params[:question_id])
  end

  def update
    @option = Option.find_by_id(params[:id])
    @question = Question.find_by_id(params[:question_id])
    @option.option_label = params[:option_label]
    @option.option_value = params[:option_value]
    @option.question_id = params[:question_id]
    @option.option_type = params[:option_type]
    @option.order = params[:order]
    @option.save
    respond_with Form.find(params[:form_id]),@question, @option
  end

  def destroy
    respond_with Option.destroy(params[:id])
  end
end
