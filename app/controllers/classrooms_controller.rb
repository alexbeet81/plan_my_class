class ClassroomsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]

  def index
    @classrooms = Classroom.all
  end

  def show
  end

  def new
  end

  def create
    @classroom = Classroom.new(classroom_params)

    if @classroom.save
      redirect_to classroom_path(@classroom)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @classroom.update(classroom_params)
      redirect_to classroom_path(@classroom)
    else
      render :edit
    end
  end

  def destroy
    if @classroom.destroy
      redirect_to classrooms_path, notice: 'Classroom was successfully deleted.'
    else
      redirect_to classroom_path(@classroom), alert: 'Classroom could not be deleted.'
    end
  end

  private

  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

  def classroom_params
    params.require(:classroom).permit(:name, :columns, :rows, :teacher_id)
  end
end