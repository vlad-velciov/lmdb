Rack::Attack.throttle('requests by ip', limit: 1, period: 5) do |request|
  request.ip
end
