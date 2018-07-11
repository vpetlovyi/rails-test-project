module BreedsFetcher
  def self.fetch
    JSON.parse(RestClient.get("https://dog.ceo/api/breeds/list/all").body)["message"]
  rescue StandardError => e
    Rails.logger.info e
    []
  end

  def self.random_image(breed)
    begin
      { breed: breed, image_url: self.get_image(breed) }
    rescue StandardError => e
      Rails.logger.info e
      nil
    end
  end

  def self.get_image(breed)
    JSON.parse(RestClient.get("https://dog.ceo/api/breed/#{breed}/images/random").body)['message']
  end
end
