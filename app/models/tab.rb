class Tab < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_en, use: [:slugged, :finders]
  validates :title_en, :title_ru, :text_en, :text_ru, presence: true

  def slug_candidates
    [:title_en, [:id, :title_en]]
  end

  def should_generate_new_friendly_id?
    title_en_changed? || !has_friendly_id_slug?
  end

  def has_friendly_id_slug?
    Tab.where(slug: slug).exists?
  end

  def normalize_friendly_id(string)
    super.gsub("-", "_")
  end
end
