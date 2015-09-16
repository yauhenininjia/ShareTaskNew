class RaterController < ApplicationController

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_i, current_user, params[:dimension]

      render :json => { rating: obj.rates(:description).average(:stars).to_f.round(1),
      					data_id: obj.id }
    else
      render :json => false
    end
  end

end
