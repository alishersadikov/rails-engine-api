class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    sprintf "%.2f", "#{object/100.00}"
  end

end
