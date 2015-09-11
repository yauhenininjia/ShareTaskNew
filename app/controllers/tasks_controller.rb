class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
  	@tasks = current_user.tasks.all
    render @tasks
  end

  def new
    @user = current_user
  	@task = @user.tasks.new
  end

  def create
  	current_user.tasks.create(task_params)
  	redirect_to :back
  end

  private
    def task_params
      params.require(:task).permit(:name, :description)
    end

end
