module Concerns
  module Users
    module OnlineStatus
      extend ActiveSupport::Concern

      USER_COUNT = 'online_users'
      USER_MAPPING = 'user_client_mapping'

      included do
        scope :online, -> { where(channel_key: $redis.hgetall(USER_COUNT).keys ) }
      end

      def online?
        $redis.hget(USER_COUNT, self.channel_key).to_i > 0
      end

      module ClassMethods
        def online_count
          $redis.hlen USER_COUNT
        end

        def find_by_client_id(client_id)
          where(channel_key: $redis.hmget(USER_MAPPING, client_id)).first
        end
      end

    end
  end
end