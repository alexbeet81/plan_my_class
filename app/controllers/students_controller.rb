class StudentsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_student, only: [:edit, :update, :destroy]

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if @student.save
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      # TODO: Add flash message success
    else
      # TODO: Flash error message
      render :edit
    end
  end

  def destroy
    if @student.destroy
      # TODO: Add student removed successfully.
    else
      # TODO: error messsage
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end
end
