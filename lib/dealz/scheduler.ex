defmodule Dealz.Scheduler do
  use Quantum,
    otp_app: :dealz

  def crawl do
    Crawly.Engine.start_spider(Dealz.TravelDealzSpider)
  end
end
