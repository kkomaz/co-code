class ClientEvent
  HASH_KEY = 'online_users'

  def self.user_subscribe(channel_key)
    $redis.hincrby(HASH_KEY, channel_key, 1)
  end

  def self.user_unsubscribe(channel_key)
    user_connections = $redis.hincrby(HASH_KEY, channel_key, -1)
    $redis.hdel(HASH_KEY, channel_key) if user_connections <= 0
  end

end

