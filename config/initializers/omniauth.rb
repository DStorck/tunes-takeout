Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"]
end
