# == Schema Information
#
# Table name: visits
#
#  id           :bigint(8)        not null, primary key
#  short_url_id :integer          not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Visit < ApplicationRecord
    validates :short_url_id, :user_id, presence: true 

    def self.record_visit!(user, shortened_url)
        Visit.create!(user_id: user.id, short_url_id: shortened_url.id)
    end

    belongs_to :visitor,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id

    belongs_to :visited_url,
        class_name: 'ShortenedUrl',
        foreign_key: :short_url_id,
        primary_key: :id
end
