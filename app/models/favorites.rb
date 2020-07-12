class Favorites
  attr_reader :favorite_pets
  def initialize(favorite_pets)
    @favorite_pets = favorite_pets || Array.new
  end

  def add(pet_id)
    @favorite_pets << pet_id
  end

  def pet_ids
    @favorited_pets
  end

  def sum_favorites
    @favorite_pets.count
  end

  def is_already_favorited?(pet_id)
    @favorite_pets.include?(pet_id.to_s)
  end

  def delete(pet_ids)
    @favorite_pets.delete(pet_ids)
  end
end
