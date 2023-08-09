defmodule BasicSpider do
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
      |> Enum.map(fn x -> Floki.attribute(x, "title") end)
      |> Enum.filter(fn x -> contains_keywords?(Floki.text(x)) end)

    IO.inspect(deals)

    %Crawly.ParsedItem{
      :items => deals,
      :requests => []
    }
  end

  def contains_keywords?(string) do
    keywords = ["Madrid", "Mexico", "Copenhagen", "Denmark", "Australia"] 
    matches = for k <- keywords do
      String.contains?(string, k)
    end

    if Enum.member?(matches, true), do: true, else: false
  end
end
