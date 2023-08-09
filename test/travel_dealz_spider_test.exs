defmodule TravelDealzSpiderTest do
  alias Dealz.TravelDealzSpider
  use ExUnit.Case

  test "parse_item/1" do
    assert Dealz.TravelDealzSpider.parse_item == :world
  end

  test "find_deals/1" do
    test_html = "
      <article>
        <header>
          <a href='link-to-deal' title='Great deal from Copenhagen to Mexico!'>Great deal from Copenhagen to Mexico!</a>
        </header>
      </article>

      <article>
        <header>
          <a href='link-to-another-deal' title='Great deal from Argentina to Madrid!'>Great deal from Argentina to Madrid!</a>
        </header>
      </article>
    "
    expectation = TravelDealzSpider.find_deals(test_html)
    assert expectation == [%{href: "link-to-deal", title: "Great deal from Copenhagen to Mexico!"}]
  end
end
