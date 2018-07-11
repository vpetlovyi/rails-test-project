REDIS = if Rails.env.development?
          Redis.new
        else
          Redis.new(url: ENV["REDIS_URL"])
        end
