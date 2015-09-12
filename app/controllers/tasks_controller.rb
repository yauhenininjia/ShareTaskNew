class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
  	@tasks = current_user.tasks.all
    render @tasks
  end

  def new
  	@task = current_user.tasks.new
  end

  def create
  	@task = current_user.tasks.new(task_params)
    if @task.save
  	  redirect_to :back, notice: 'Successfully saved'
    else
      #redirect_to :back, notice: 'Was not saved'
      render 'new', notice: "Was not saved"
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :description)
    end

end
