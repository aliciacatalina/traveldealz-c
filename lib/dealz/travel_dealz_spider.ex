defmodule Dealz.TravelDealzSpider do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url do
    "https://travel-dealz.com/"
  end

  @impl Crawly.Spider
  def init() do
    [
      start_urls: [
        "https://travel-dealz.com/"
      ]
    ]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, document} =
      response.body
      |> Floki.parse_document()

    deals =
      document
      |> Floki.find("article a")
      |> Enum.map(fn x -> Floki.attribute(x, "title") end) # i could move ve this to a funciton and create a map with the href and the title
      |> Enum.filter(fn x -> contains_keywords?(Floki.text(x)) end)
      |> Enum.uniq

    IO.inspect(deals)


    send_email(Enum.join(deals, "\n"))

    %Crawly.ParsedItem{
      :items => deals,
      :requests => []
    }
  end

  def contains_keywords?(string) do
    keywords = ["Madrid", "Mexico", "Copenhagen", "Denmark", "Australia"]

    matches =
      for k <- keywords do
        String.contains?(string, k)
      end

    if Enum.member?(matches, true), do: true, else: false
  end

  def send_email(dealz) do
    # Create your email
    email = Dealz.Email.dealz_email(dealz)

    try do
      Dealz.Mailer.deliver_now(email)
    rescue
      error in Bamboo.SMTPAdapter.SMTPError ->
        case error.raw do
          {:retries_exceeded, _} ->
            IO.inspect("I can do some stuff when this error match")

          _ ->
            IO.inspect("I don't care about these ones")
        end

        # Here, I can re-raise the error
        raise error
    end
  end
end
