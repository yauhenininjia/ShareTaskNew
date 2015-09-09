class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
  	@task = Task.new
  end

end
