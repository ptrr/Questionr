class FormsController < ApplicationController
  def index
    @forms = Form.all
  end

  def edit
    @form = Form.find(params[:id])
  end

  def new
  end

  def create
    @form = Form.new(params[:form])
    if @form.save
      flash[:notice] = 'Vragenlijst aangemaakt.'
      redirect_to edit_form_path(@form)
    else
      flash[:notice] = 'Er ging iets fout.'
      render :index
    end
  end
end
