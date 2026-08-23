class Api::V1::TasksController < Api::V1::BaseController
  def index
    tasks = policy_scope(Task)
              .includes(:project, :assignee)

    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, 20).to_i

    total_count = tasks.count

    tasks = tasks
              .offset((page - 1) * per_page)
              .limit(per_page)

    render json: {
      tasks: tasks.map do |task|
        {
          id: task.id,
          title: task.title,
          status: task.status,
          due_on: task.due_on,
          project_id: task.project_id,
          assignee_id: task.assignee_id
        }
      end,
      meta: {
        page: page,
        per_page: per_page,
        total_count: total_count
      }
    }
  end

  def create
    @task = Task.new(task_params)
    authorize @task

    if @task.save
      render json: task_json(@task), status: :created
    else
      render json: { errors: @task.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    authorize @task

    if @task.update(task_params)
      render json: task_json(@task), status: :ok
    else
      render json: { errors: @task.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(
      :title,
      :status,
      :due_on,
      :project_id,
      :assignee_id
    )
  end

  def task_json(task)
    {
      id: task.id,
      title: task.title,
      status: task.status,
      due_on: task.due_on,
      project_id: task.project_id,
      assignee_id: task.assignee_id
    }
  end
end