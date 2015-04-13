class Subscribe
  USER_COUNT = 'online_users'
  USER_MAPPING = 'user_client_mapping'

  def initialize(channel, client_id)
    @client_id = client_id
    @channel = channel
    if channel["/users/status/"]
      @channel_info = channel.gsub("/users/status/","")
      status_subscribe
    elsif channel[/rooms\/\d+/]
      @channel_info = channel[/rooms\/\d+/].gsub("rooms/","")
      room_subscribe
    end
  end

  def status_subscribe
    increase_user_count
    add_user_mapping
  end

  def room_subscribe
    add_client_to_room
    publish_room_entry
  end

  private
    def increase_user_count
      $redis.hincrby(USER_COUNT, @channel_info, 1)
    end

    def add_user_mapping
      $redis.hset(USER_MAPPING, @client_id, @channel_info)
    end

    def add_client_to_room
      $redis.sadd(@channel_info, @client_id)
    end

    def publish_room_entry
      # # url = "http://co-code.herokuapp.com" + @channel + "/enter"
      # url = "http://127.0.0.1:3000" + @channel + "/enter"
      # uri = URI.parse(url)
      # http = Net::HTTP.new(uri.host, uri.port)
      # request = Net::HTTP::Post.new(uri.path, {"client_id" => @client_id})
      # puts request.body

      # response = http.request(request)
      # puts response
      url = URI.parse('https://www.google.com/?gws_rd=ssl')
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port, use_ssl: true) {|http| http.request(req)}
      puts res.body
    end
end

      # url = "http://localhost:3000/ruby/problem-1/rooms/1/enter"
      # uri = URI.parse(url)
      # http = Net::HTTP.new(uri.host, uri.port)
      # request = Net::HTTP::Post.new(uri.path, {"client_id" => "f6i8o9u40yauk4magqxxa1a97ffub5w"})
      # response = http.request(request)

