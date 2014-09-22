json.array!(@users) do |user|
  json.extract! user, :id, :user_name, :password, :login_counter
  json.url user_url(user, format: :json)
end
