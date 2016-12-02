class RevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    sprintf "%.2f", object/100.00
  end
end
