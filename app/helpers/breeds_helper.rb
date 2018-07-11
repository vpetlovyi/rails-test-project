module BreedsHelper
  def humanize(name)
    name.split('/').reverse.map(&:classify).join(' ')
  end
end
