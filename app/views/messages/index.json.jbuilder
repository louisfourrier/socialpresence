json.array!(@messages) do |message|
  json.extract! message, :id, :service_id, :service_token, :content, :url, :from_url, :tags
  json.url message_url(message, format: :json)
end
