class Dashboard::TrainersController < Dashboard::BaseController

  def index
    result = ShowCard.call(
      id: params[:id],
      user: current_user
    )

    @card = result.card

    respond_to do |format|
      format.html
      format.js
    end
  end

  def review_card
    result = ReviewCard.call(
      user: current_user,
      id: params[:card_id],
      user_translation: trainer_params[:user_translation]
    )

    @card = result.card

    if result.success?
      redirect_to trainer_path, notice: result.message
    else
      redirect_to trainer_path(id: @card.id), alert: result.message
    end
  end

  private

  def trainer_params
    params.permit(:user_translation)
  end
end
