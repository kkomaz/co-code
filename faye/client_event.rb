class ClientEvent
  MONITORED_CHANNELS = [ '/meta/subscribe', '/meta/disconnect' ]

  def incoming(message, callback)
    return callback.call(message) unless MONITORED_CHANNELS.include? message['channel']

    puts "Message is: #{message.inspect}"
    faye_client.publish(message["subscription"], { 'message' => {'content' => "An event happened!"} } )
    callback.call(message)
  end

  def faye_client
    @faye_client ||= Faye::Client.new('http://localhost:9292/faye')
  end

  def room_id (message)
    message["subscription"][/\d+/].gsub("/","")
  end

end