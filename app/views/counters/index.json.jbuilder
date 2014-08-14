json.array!(@counters) do |counter|
  json.extract! counter, :id, :sleepcount, :twitime
  json.url counter_url(counter, format: :json)
end
