class Game < ApplicationRecord
  belongs_to :schedule
  belongs_to :stadium, optional: true

  has_many :results, dependent: :destroy, inverse_of: :game
  accepts_nested_attributes_for :results
  default_scope { order(:id) }

  # validates :stadium, uniqueness: { allow_blank: true, allow_nil: true }
  validates :schedule, presence: true

  scope :in_week, ->(week_number, year) {
    where(
      "EXTRACT(week FROM COALESCE(games.alternative_date, schedules.day)) = ? " \
      "AND EXTRACT(year FROM COALESCE(games.alternative_date, schedules.day)) = ?",
      week_number, year
    ).joins(:schedule)
  }

  # TODO : chat Mistral "select model by week..."
  def self.in_week_grouped_by_edition_and_schedule(week_number, year)
    in_week(week_number, year)
      .includes(:schedule)
      .group_by { |game| game.schedule.edition }
      .transform_values do |games_in_edition|
        games_in_edition.group_by { |game| game.schedule }
      end
  end

  def played?
    status == "played"
  end

  def day
    alternative_date || schedule.day
  end
end
