class DocentsController < ApplicationController

  def index
    @docents = Docent.all
  end

  def new 
    @docent = Docent.new
  end

  def show
    @docent = Docent.find(params[:id])
  end

  def create
    @docent = Docent.new(docent_params)
    @docent.save
    redirect_to @docent
  end

  private
    def docent_params
      params.require(:docent).permit(:name,:bio,:email,:profile_picture)
    end

end