module Concerns
  module Users
    module OnlineStatus
      extend ActiveSupport::Concern

      HASH_KEY = 'online_users'

      included do
        scope :online, -> { where(channel_key: $redis.hgetall(HASH_KEY).keys ) }
      end

      def online?
        $redis.hget(HASH_KEY, self.channel_key).to_i > 0
      end

      module ClassMethods
        def online_count
          $redis.hlen HASH_KEY
        end
      end

    end
  end
end