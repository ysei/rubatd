module Rubatd
  module RedisAccessors
    def self.for(db, model_type)
      const_get(model_type).new(db)
    end
  end
end

require "rubatd/redis_accessors/base"
require "rubatd/redis_accessors/team"
require "rubatd/redis_accessors/teammate"