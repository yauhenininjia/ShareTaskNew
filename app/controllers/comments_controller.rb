class CommentsController < ApplicationController

	def create
	  @task = Task.find(params[:task_id])
	  @user = User.find(params[:user_id])
	  comment = Comment.create comment_params.merge({user_id: @user.id, task_id: @task.id})
	  @task.comments << comment
	  @user.comments << comment
	  render @task
  end
 
  private
    def comment_params
      params.require(:comment).permit(:body)
    end

end
