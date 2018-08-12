class TeasChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'teas'
  end
end
