class BreedsController < ApplicationController

  def index
    @breed = DogBreedFetcher.fetch
  end

end
