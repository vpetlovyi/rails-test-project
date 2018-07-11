class DogBreedFetcher
  attr_reader :breed

  def initialize(name=nil)
    @name  = breed || "random"
    @breed = Breed.find_or_initialize_by(name: name)
  end

  def fetch
    return @breed if @breed.pic_url.present?

    @breed.pic_url = fetch_info["message"]
    @breed.save && @breed
  end

  def self.fetch(name=nil)
    name ||= "random"
    DogBreedFetcher.new(name).fetch
  end

private


  def default_body
    {
      "status"  => "success",
      "message" => "https://images.dog.ceo/breeds/cattledog-australian/IMG_2432.jpg"
    }
  end
end
