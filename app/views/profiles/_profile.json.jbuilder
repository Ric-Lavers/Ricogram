json.extract! profile, :id, :avartar_data, :user_name, :bio, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
