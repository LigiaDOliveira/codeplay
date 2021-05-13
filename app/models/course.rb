class Course < ApplicationRecord
  def price_brl
    "R$ #{price},00"
  end
end
