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

    deals = parse_deals(document)

    %Crawly.ParsedItem{
      :items => deals,
      :requests => []
    }

    # move this to another place
    formatted_deals = build_deals(deals)
    Dealz.Email.send_email(formatted_deals)
  end

  def parse_deals(document) do
    deals = find_deals(document)
      |> build_deals
      |> find_relevant_deals
  end

  def find_deals(document) do
    document
      |> Floki.find("article header a")
      |> build_deals
      |> find_relevant_deals
      |> unique_deals
  end

  def build_deals(items) do
    Enum.map(items, fn item ->
      %{
        href: hd(Floki.attribute(item, "href")),
        title: hd(Floki.attribute(item, "title"))
      }
    end
    )
  end

  def find_relevant_deals(deals) do
    Enum.filter(deals, fn anchor -> contains_keywords?(anchor[:title]) end)
  end

  def unique_deals(deals) do
    Enum.uniq_by(deals, fn anchor -> anchor[:href] end)
  end

  def contains_keywords?(string) do
    keywords = ["Mexico", "Copenhagen", "Denmark", "Australia", "Cancun", "Melbourne"]

    matches =
      for k <- keywords do
        String.contains?(string, k)
      end

    if Enum.member?(matches, true), do: true, else: false
  end

  def build_email(deals) do
    html =
      for deal <- deals do
        "<a href=#{deal[:href]}>#{deal[:title]}</a>"
      end
  end
end
