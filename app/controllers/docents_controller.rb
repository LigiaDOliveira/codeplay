class DocentsController < ApplicationController

  def index
    @docents = Docent.all
  end

  def new 
    @docent = Docent.new
  end

  def edit
    @docent = Docent.find(params[:id])
  end

  def show
    @docent = Docent.find(params[:id])
  end

  def create
    @docent = Docent.new(docent_params)
    if @docent.save
      redirect_to @docent
    else
      flash[:error_new]=[]
      @docent.errors.each do |error|
        flash[:error_new] << error.message
      end
      render :new
    end
  end

  def update
    @docent = Docent.find(params[:id])
    if @docent.update(docent_params)
      redirect_to @docent
    else
      flash[:error_new]=[]
      @docent.errors.each do |error|
        flash[:error_new] << error.message
      end
      render :new
    end
  end

  private
    def docent_params
      params.require(:docent).permit(:name,:bio,:email,:profile_picture)
    end

end