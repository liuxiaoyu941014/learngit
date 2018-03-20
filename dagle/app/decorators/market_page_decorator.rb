class MarketPageDecorator < Decorator::Base

  # def display_name
  #   h.content_tag :span, class: 'title' do
  #     name
  #   end
  # end

  def created_at
    distance_of_time_in_words_to_now(super)
  end

end
