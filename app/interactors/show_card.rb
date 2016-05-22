class ShowCard
  include Interactor

  def call
    user = context.user
    id = context.id

    if id
      context.card = user.cards.find(id)
    else
      if user.current_block
        context.card = user.current_block.cards.pending.first
        context.card ||= user.current_block.cards.repeating.first
      else
        context.card = user.cards.pending.first
        context.card ||= user.cards.repeating.first
      end
    end
  end
end
