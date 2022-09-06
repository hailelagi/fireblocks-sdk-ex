import Config

config :fireblocks,
  env: config_env(),
  webhook_url: {:system, "FIREBLOCKS_WEBHOOK_URL"},
  redirect_url: {:system, "FIREBLOCKS_REDIRECT_URL"},
  base_url: {:system, "FIREBLOCKS_BASE_URL", "https://api.fireblocks.io"},
  client: Fireblocks.Client,
  api_secret: {:system, "FIREBLOCKS_API_SECRET"},
  api_key: {:system, "FIREBLOCKS_API_KEY"}

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: ~w[application initial_call mfa request_id remote_ip]a

import_config "#{config_env()}.exs"
