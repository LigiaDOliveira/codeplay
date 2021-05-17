class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new 
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      flash[:error_new]=[]
      @course.errors.each do |error|
        flash[:error_new] << error.message
      end
      render :new
    end
  end

  private
    def course_params
      params.require(:course).permit(:name,:description,:code,:price,:enrollment_deadline)
    end
end