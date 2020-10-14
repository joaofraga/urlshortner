class Url < ApplicationRecord
  after_create :generate_short_code, unless: :has_short?
  before_create :scrap_title

  validates_presence_of :original
  validates :original, format: { with: URI.regexp }

  def count_view!
    self.views += 1
    self.save
  end

  private

  def generate_short_code
    self.short = BijectiveEncodingService.encode(self.id)
    self.save
  end

  #TODO: Move to a background job
  def scrap_title
    scrap = ScrapperService.new(self.original)
    self.title = scrap.title
  end

  def has_short?
    self.short.present?
  end
end
