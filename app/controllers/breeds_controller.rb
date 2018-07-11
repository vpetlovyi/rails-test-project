class BreedsController < ApplicationController
  include BreedsHelper

  before_action :set_breeds

  def index; end

  def show
    breed = params[:id].gsub('-', '/')
    @breed = RedisCache.fetch(breed, CACHE_MINUTES) do
      BreedsFetcher.random_image(breed)
    end
    @breed = OpenStruct.new(@breed)
  end

  protected

  def format_breeds(breeds)
    new_breeds = []
    breeds.each do |breed, subbreeds|
      if subbreeds.blank?
        new_breeds.push breed
      else 
        new_breeds = new_breeds.concat(subbreeds.map { |sub| "#{breed}/#{sub}" })
      end
    end
    new_breeds
  end

  private

  def set_breeds
    @breeds = RedisCache.fetch('breeds', CACHE_MINUTES) do
      format_breeds(BreedsFetcher.fetch)
    end
  end
end
