class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :tag_cloud
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  def index
  	@tasks = current_user.tasks.all
  end

  def new
  	@task = current_user.tasks.new
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

    if @task.save
  	  redirect_to :back, notice: 'Successfully saved'
    else
      render 'new', notice: "Was not saved"
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy

  end

  def search_tasks_by_tag
    @tasks = Task.tagged_with params[:tag]
    render 'index'
  end

  def search_tasks_by_section
    @tasks = Task.where section: params[:section]
    render 'index'
  end


  private
    def task_params
      params.require(:task).permit(:section, :name, :description, :images => [] )
    end

end
