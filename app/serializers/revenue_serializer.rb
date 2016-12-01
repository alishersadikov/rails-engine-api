class RevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    "#{object/100.00}"
  end

end
