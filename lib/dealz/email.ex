defmodule Dealz.Email do
  import Bamboo.Email
  @from_address "alicia.gonzalez.90@gmail.com"
  @to_address "alicia.gonzalez.90@gmail.com"
  @cc_address "andres.draco.21@gmail.com"
  @subject "Dealz of the day"

  def send_email(dealz) do
    message = dealz

    new_email()
    |> to(@to_address)
    |> bcc(@cc_address)
    |> from(@from_address)
    |> subject(@subject)
    |> html_body(message)
  end
end
