class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
  	@tasks = current_user.tasks.all
  end

  def new
  	@task = current_user.tasks.new
  end

  def create
  	@task = current_user.tasks.new(task_params)
    render text: params
    #if @task.save
  	#  redirect_to :back, notice: 'Successfully saved'
    #else
    #  render 'new', notice: "Was not saved"
    #end
  end

  def show
    @task = Task.find(params[:id])
  end


  private
    def task_params
      params.require(:task).permit(:section, :name, :description)
    end

end
