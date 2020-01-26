use Mix.Config

config :jamstack,
  ecto_repos: [Jamstack.Repo]

config :jamstack, JamstackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ImhOXB/didTflmXEafsXXHbyDywN+TPo/ZlijIcTf1vNtgjU2VdG3GZYfct34+uh",
  render_errors: [view: JamstackWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Jamstack.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
import_config "#{Mix.env()}.spotify.exs"
