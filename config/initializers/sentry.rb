Sentry.init do |config|
  config.dsn = 'https://6ba979e149829f487ecd9bf78d407688@o4511822158168064.ingest.us.sentry.io/4511822164721664'
  config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true
end
