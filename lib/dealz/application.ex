defmodule Dealz.Application do
  use Application

  def start(_type, _args) do
    children = [
      # This is the new line
      Dealz.Scheduler
    ]

    opts = [strategy: :one_for_one, name: Dealz.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
