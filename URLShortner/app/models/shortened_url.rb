# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'SecureRandom'

class ShortenedUrl < ApplicationRecord
    include SecureRandom
    validates :short_url, :long_url, :user_id, uniqueness: true, presence: true 

    def self.random_code
        potential_short_url = SecureRandom.urlsafe_base64
        until !ShortenedUrl.where(:short_url => potential_short_url).exists?
            potential_short_url = SecureRandom.urlsafe_base64
        end

        potential_short_url
    end

    def self.new_instance(user, long)
        ShortenedUrl.create!(short_url: ShortenedUrl.random_code, 
        long_url: long, user_id: user.id)
    end

    def num_clicks
        self.url_visits.length 
    end 

    def num_uniques
        count = Hash.new(0)
        self.url_visits.each do |visit|
            count[visit.user_id] += 1
        end 
        count.keys.length
    endte

    belongs_to :submitter,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id

    has_many :url_visits,
        class_name: 'Visit',
        foreign_key: :short_url_id,
        primary_key: :id

    has_many :visitors, through: :url_visits, source: :visitor

end
