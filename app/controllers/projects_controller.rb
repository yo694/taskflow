class ProjectsController < ApplicationController

  def index 
    @projects = policy_scope(Project)
  end
  
  def show
    @project = Project.find(params[:id])
    authorize @project
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.owned_projects.build(project_params)

    if @project.save
      redirect_to @project, notice: "Project created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    @project = Project.find(param[:id])
    authorize @project

    if @project.update(project_params)
      redirect_to @project, notice: "Project updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    authorize @project

    @project.destroy
    redirect_to projects_path,notice: "Project deleted successfully."
  end


  private

  def project_params
    params.require(:project).permit(:name, :description)
  end



end
