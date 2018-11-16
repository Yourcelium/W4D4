# == Schema Information
#
# Table name: albums
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :integer          not null
#  title      :string           not null
#  yr         :integer          not null
#  live       :boolean          not null
#

class Album < ApplicationRecord
    validates :band_id, :title, :yr, presence: true
    validates :live, inclusion: [true, false]

    belongs_to :band,
        foreign_key: :band_id,
        class_name: :Band

end
