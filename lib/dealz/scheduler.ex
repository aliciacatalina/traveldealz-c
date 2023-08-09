defmodule Dealz.Scheduler do
  use Quantum,
    otp_app: :dealz

  def crawl do
    IO.inspect("starting the crawling")
    Crawly.Engine.start_spider(Dealz.TravelDealzSpider)
  end
end
