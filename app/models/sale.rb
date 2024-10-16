class Sale < ApplicationRecord
  belongs_to :affiliate

  validates_presence_of :affiliate, presence: true, :message => "Refcode must exist!"

  def buyer_name
    return "#{self.firstname} #{self.lastname}"
  end

  def ref_code
    return self.affiliate_id.to_s.rjust(4, '0')
  end
end
