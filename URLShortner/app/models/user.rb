# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord

    validates :email, presence: true, uniqueness: true
    # def uniq_err
    #     errors[:email] << "Email must be unique" if 
    # end

    has_many :submitted_urls,
        class_name: 'ShortenedUrl',
        foreign_key: :user_id,
        primary_key: :id

    has_many :user_visits,
        class_name: 'Visit',
        foreign_key: :user_id,
        primary_key: :id

    has_many :visited_urls, through: :user_visits, source: :visited_url
end
