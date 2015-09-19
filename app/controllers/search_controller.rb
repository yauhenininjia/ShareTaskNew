class SearchController < ApplicationController
  def search
  	@tasks = Task.search params[:query]
  	render 'tasks/index'
  end

  def tasks_by_tag
    @tasks = Task.tagged_with params[:tag]
    render 'tasks/index'
  end

  def tasks_by_section
    @tasks = Task.where section: params[:section]
    render 'tasks/index'
  end

  def tasks_by_user
    @tasks = Task.where user_id: params[:user_id]
    render 'tasks/index'
  end
end
