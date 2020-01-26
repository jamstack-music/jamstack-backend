use Mix.Config

config :spotify_ex,
  user_id: "zchbndcc9",
  scopes: ["playlist-read-collaborative", "playlist-read-private", "user-library-read"]

import_config "secret.spotify.exs"
