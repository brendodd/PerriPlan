class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :bookable, polymorphic: true
  has_many :reviews, dependent: :destroy

  def self.dedupe
    grouped = all.group_by { |model| [model.bookable_id, model.user_id] }

    grouped.values.each do |duplicates|
      first_one = duplicates.shift
      duplicates.each{|double| double.destroy}
    end
  end
end
