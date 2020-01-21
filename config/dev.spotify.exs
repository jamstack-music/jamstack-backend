use Mix.Config

config :spotify_ex,
  callback_url: "jamstack://auth" 

import_config "spotify.exs"
