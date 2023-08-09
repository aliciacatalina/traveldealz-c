defmodule Dealz.Mailer do
  use Bamboo.Mailer, otp_app: :dealz

  def send_email(email) do
    try do
      Dealz.Mailer.deliver_now(email)
    rescue
      error in Bamboo.SMTPAdapter.SMTPError ->
        case error.raw do
          {:retries_exceeded, _} ->
            IO.inspect("Retries exceeded")

          _ ->
            IO.inspect("Unexpected error")
        end

        raise error
    end
  end
end
