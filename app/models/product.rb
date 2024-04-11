class Product < ApplicationRecord
  belongs_to :category

  def as_json(options={})
    super(only: [:title, :description, :price ], include: [ :category ])
  end

end
