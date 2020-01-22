defmodule Jamstack.Dictionary do
  use Agent

  defstruct(
    nouns: [],
    adjectives: []
  )

  def start_link(_) do
    nouns_task = Task.async(fn -> load_words("./assets/nouns.txt") end)
    adjectives_task = Task.async(fn -> load_words("./assets/adjectives.txt") end)

    dictionary = %__MODULE__ {
      nouns: Task.await(nouns_task),
      adjectives: Task.await(adjectives_task)
    }

    Agent.start_link(fn -> dictionary end, name: __MODULE__) 
  end
  
  def get_random_noun() do
    Agent.get(__MODULE__, fn %__MODULE__{ nouns: words} -> words |> Enum.random() end)
  end

  def get_random_adjective() do
    Agent.get(__MODULE__, fn %__MODULE__{ adjectives: words} -> words |> Enum.random() end)
  end

  def load_words(file) do
    file
    |> File.read!()
    |> String.split("\n")
  end
end
