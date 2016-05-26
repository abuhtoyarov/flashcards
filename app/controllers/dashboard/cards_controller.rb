class Dashboard::CardsController < Dashboard::BaseController
  before_action :set_card, only: [:destroy, :edit, :update]

  def index
    @cards = current_user.cards.sorted_by_review_date
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.create(card_params)
    respond_with(@card, location: cards_path)
  end

  def update
    @card.update(card_params)
    respond_with(@card, location: cards_path)
  end

  def destroy
    @card.destroy
    respond_with @card
  end

  private

  def set_card
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date,
                                 :image, :image_cache, :remove_image, :block_id)
  end
end
