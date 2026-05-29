# Allow cross-origin requests from the static landing site (ivanplab.ru)
# to public endpoints (currently only the contact form).
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://ivanplab.ru',
            'http://ivanplab.ru',
            'http://localhost:8000',
            'http://localhost:8080',
            'http://localhost:3000',
            'http://127.0.0.1:8000',
            'http://127.0.0.1:8080'

    resource '/contact',
             headers: :any,
             methods: [:post, :options],
             max_age: 600
  end
end
