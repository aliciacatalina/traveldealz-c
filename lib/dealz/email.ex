defmodule Dealz.Email do
  import Bamboo.Email
  @from_address "alicia.gonzalez.90@gmail.com"
  @to_address "alicia.gonzalez.90@gmail.com"
  @subject "Dealz of the day"

  def dealz_email(dealz) do
    message = dealz

    new_email()
    |> to(@to_address)
    |> from(@from_address)
    |> subject(@subject)
    |> text_body(message)
  end
end
