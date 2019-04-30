class Catalog < ApplicationRecord
    has_many :catalog_courses
    has_many :courses, through: :catalog_courses
end
