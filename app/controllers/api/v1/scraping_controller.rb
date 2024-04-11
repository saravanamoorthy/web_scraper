class Api::V1::ScrapingController < ApplicationController

	def create
		render json: { message: "URL missing. Please submit with a valid URL." } and return unless params[:url].present?

		ScrapeJob.perform_later(params[:url])
		render json: { message: "Your request has been successfully submitted for web scraping. Please check back later for the scraped data." }
  end

end
