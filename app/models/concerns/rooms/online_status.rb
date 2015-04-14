module Concerns
  module Rooms
    module OnlineStatus
      extend ActiveSupport::Concern

      USER_MAPPING = 'user_client_mapping'

      def active_users
        if !active_clients.empty?
        User.where(:channel_key => active_channel_keys)
        else
          []
        end
      end

      def active_channel_keys
        $redis.hmget(USER_MAPPING, active_clients).compact
      end

      def active_clients
        $redis.smembers(self.id)
      end

    end
  end
end