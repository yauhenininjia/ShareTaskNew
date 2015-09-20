class AttemptsController < ApplicationController
  
  def new
  	@attempt = Attempt.new
  end

  def create
  	@attempt = Attempt.new(attempt_params)
  	@attempt.answered = Task.find(@attempt.task_id).answers.pluck(:body).include? @attempt.attempt_answer
  	@attempt.save
  	if @attempt.answered
  		@message = t('attempt.right_answer')
  	else
  		@message = t('attempt.wrong_answer')
  	end
  	respond_to do |format|
  	  format.js { }
  	end
  end

  private
  	def attempt_params
  	  params.require(:attempt).permit(:attempt_answer, :user_id, :task_id)
  	end

end
