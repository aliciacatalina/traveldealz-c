defmodule Dealz.Application do
  use Application

  def start(_type, _args) do
    children = [
      Dealz.Scheduler
    ]

    opts = [strategy: :one_for_one, name: Dealz.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
