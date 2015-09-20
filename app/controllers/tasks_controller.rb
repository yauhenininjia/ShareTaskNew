class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :tag_cloud
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  def index
  	@tasks = Task.paginate(:page => params[:page], per_page: per_page)#all
    @tasks.reverse_order!
  end

  def new
  	@task = current_user.tasks.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
  	@task = current_user.tasks.new(task_params)
    if params[:task][:image]
      params[:task][:image].each do |image|
        @task.images.new(:url => image)
      end
    end

    if params[:task][:tags]
      params[:task][:tags].first.split(tag_separator).each do |tag|
        @task.tag_list.add(tag)
      end
    end

    if params[:task][:answers]
      params[:task][:answers].each do |answer|
        @task.answers.new(:body => answer)
      end
    end

    if @task.save
  	  redirect_to task_path(current_locale, @task.id), notice: 'Successfully saved'
    else
      render 'new', notice: "Was not saved"
    end
  end

  def update
    render text: params
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    task = Task.find params[:id]
    task.destroy
    redirect_to tasks_path
  end

  


  private
    def task_params
      params.require(:task).permit(:section, :name, :description )
    end

end
