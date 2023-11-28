# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://3bf6590de2eb807d31343f93a2c349bc@o1143052.ingest.sentry.io/4506100845772800'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.enabled_environments = %w[production]
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
