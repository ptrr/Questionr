class QuestionsController < ApplicationController
  respond_to :json

  def index
    respond_with Question.where(:form_id => params[:form_id]).all
  end

  def show
    respond_with Question.find(params[:id])
  end

  def create
    @question = Question.new(params[:question])
    @question.form_id = params[:form_id]
    @question.save
    respond_with Form.find(params[:form_id]), @question
  end

  def update
    @question = Question.find(params[:id])
    @question.save
    respond_with Form.find(params[:form_id]), @question
  end

  def destroy
    respond_with Question.destroy(params[:id])
  end
end
