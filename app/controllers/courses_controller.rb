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
    @course.save
    redirect_to @course
  end

  def course_params
    params.require(:course).permit(:name,:description,:code,:price,:enrollment_deadline)
  end
end