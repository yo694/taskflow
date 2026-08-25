class TasksController < ApplicationController

 # skip_after_action :verify_policy_scoped, only: :index
  
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end

  def show
    @task = Task.find(params[:id])
    @project = @task.project
    authorize @task
  end

  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build
    authorize @task
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    authorize @task

    if @task.save
      redirect_to @task, notice: "Task created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
    @project = @task.project
    authorize @task
  end 

  def update
    @task = Task.find(params[:id])
    @project = @task.project
    authorize @task

    if @task.update(task_params)
      redirect_to @task,notic: "Task udated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    authorize @task

    @task.destroy

    redirect_to @project,notice: "Task deleted successfully."
  end

  private 

  def task_params
    params.require(:task).permit(:title,:status, :due_on, :assignee_id)
  end 
  
end
