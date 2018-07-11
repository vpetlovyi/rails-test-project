module RedisCache
  extend ActiveSupport::Concern

  def self.get_or_set(key, expire = 1)
    redis_value = self.get(key)
    
    if redis_value
      JSON.parse(redis_value).symbolize_keys
    else
      result = yield
      err = REDIS.set(key, result.to_json, ex: expire)
      result
    end
  end

  def self.get(key)
    REDIS.get(key)
  end
  
  private 

  def self.set(*args)
    
  end
  

end