class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new 
    @course = Course.new
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

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      flash[:notice] = 'Curso atualizado com sucesso'
      redirect_to @course
    else
      flash[:error_edit]=[]
      @course.errors.each do |error|
        flash[:error_edit] << error.message
      end
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = 'Curso apagado com sucesso'
    redirect_to courses_path
  end

  private
    def course_params
      params.require(:course).permit(:name,:description,:code,:price,:enrollment_deadline)
    end
end