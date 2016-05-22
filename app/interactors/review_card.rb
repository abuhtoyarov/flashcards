class ReviewCard
  include Interactor

  def call
    user = context.user
    id = context.id
    user_translation = context.user_translation

    card = context.card = user.cards.find(id)
    check_result = card.check_translation(user_translation)

    if check_result[:state]
      if check_result[:distance] == 0
        context.message = I18n.t :correct_translation_notice
      else
        context.message = I18n.t 'translation_from_misprint_alert',
                            user_translation: user_translation,
                            original_text: card.original_text,
                            translated_text: card.translated_text
      end
    else
      context.fail!(message: I18n.t(:incorrect_translation_alert))
    end
  end
end
