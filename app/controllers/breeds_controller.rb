class BreedsController < ApplicationController
  include BreedsHelper
  include RedisCache

  def index
    @breeds = RedisCache.get_or_set('breeds') do
      format_breeds(BreedsFetcher.fetch, 15.minutes)
    end
  end

  def show
    breed = params[:id].gsub('-', '/')
    @breed = RedisCache.get_or_set(breed, 15.minutes) do
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

end
