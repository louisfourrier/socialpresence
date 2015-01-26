json.array!(@services) do |service|
  json.extract! service, :id, :provider, :uid, :name, :total_field, :user_id
  json.url service_url(service, format: :json)
end
