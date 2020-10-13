class Url < ApplicationRecord
  after_create :generate_short_code, unless: :has_short?

  def count_view!
    self.views += 1
    self.save
  end

  private

  def generate_short_code
    self.short = BijectiveEncodingService.encode(self.id)
    self.save
  end

  def has_short?
    self.short.present?
  end
end
