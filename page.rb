class Page < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    # List the attributes you want to be searchable
    %w[title content slug created_at updated_at]
  end
  
    validates :slug, uniqueness: true
end
