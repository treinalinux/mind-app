# frozen_string_literal: true

# class Content
class Content < ApplicationRecord
  belongs_to :user

  validates :title, :description, presence: true
end
