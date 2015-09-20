class SearchController < ApplicationController
  def search
  	@tasks = Task.search(params[:query])#.paginate(:page => params[:page], per_page: per_page)
  	render 'tasks/index'
  end

  def tasks_by_tag
    @tasks = Task.tagged_with(params[:tag]).paginate(:page => params[:page], per_page: per_page)
    render 'tasks/index'
  end

  def tasks_by_section
    @tasks = Task.where(section: params[:section]).paginate(:page => params[:page], per_page: per_page)
    render 'tasks/index'
  end

  def tasks_by_user
    @tasks = Task.where(user_id: params[:user_id]).paginate(:page => params[:page], per_page: per_page)
    render 'tasks/index'
  end
end
