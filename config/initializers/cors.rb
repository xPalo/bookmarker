Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"

    resource "#{Rails.application.config.assets.prefix}/*",
             headers: :any,
             methods: [:get, :options]
  end
end