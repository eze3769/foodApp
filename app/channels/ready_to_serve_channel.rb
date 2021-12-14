class ReadyToServeChannel < ApplicationCable::Channel
  def subscribed
     stream_from "ready_to_serve"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
