module MessagesHelper
  def bubble_side(message)
    message.user == current_user ? "right" : "left"
  end

  def send_or_receive(message)
    message.user == current_user ? "send" : "receive"
  end
end
