class Schedule < ApplicationRecord
  default_scope { order(day: :asc) }

  # attr_accessor :first_day
  belongs_to :edition
  has_many :games, dependent: :destroy

  # after_update :delay_all_season_schedules_day

  accepts_nested_attributes_for :games
  after_update :check_results_update


  def next
    next_schedule = self.class.where("day > ?", self.day).first
    self.edition == next_schedule&.edition ? next_schedule : nil
  end

  def next_in_season
    next_schedule = self.class.where("day >= ? AND created_at > ?", self.day, self.created_at).order(:day).first
    self.season == next_schedule&.season ? next_schedule : nil
  end

  def next_in_edition
    next_schedule = self.class.where("day > ? AND edition_id = ?", self.day, self.edition_id).order(:day).first
    self.season == next_schedule&.season ? next_schedule : nil
  end

  def previous
    previous_schedule = self.class.where("day < ?", self.day).last
    self.edition == previous_schedule&.edition ? previous_schedule : nil
  end

  def previous_in_season
    previous_schedule = self.class.where("day <= ? AND created_at < ?", self.day, self.created_at).order(:day).last
    self.season == previous_schedule&.season ? previous_schedule : nil
  end

  def season
    self.edition.season
  end

  def self.delay_season_calendar_from_given_schedule(schedule_start)
    return nil unless schedule_start.is_a? Schedule

    current_season = schedule_start.edition.season
    schedule_iterator = schedule_start
    # while next schedule exist AND is still on the same season
    # so I can continue iteration
    while schedule_iterator
      if schedule_iterator.next.present?
        if schedule_iterator.next.edition.season == current_season
          # take the next schedule day to the current schedule

          schedule_iterator.update(day: schedule_iterator.next.day)
          puts "[A] - #{schedule_iterator.designation}: #{schedule_iterator.day} --> #{schedule_iterator.next.day}"
        else
          # .next exist AND next season != current_season
          # Add 7 days to the last schedule of the season

          schedule_iterator.update(day: schedule_iterator.day + 7.days)
          puts "[B] - #{schedule_iterator.designation}: #{schedule_iterator.day} --> #{schedule_iterator.day + 7.days}"
        end
      else
        # It is the last schedule record
        # Add 7 days to the last schedule of the season

        schedule_iterator.update(day: schedule_iterator.day + 7.days)
        puts "[C] - #{schedule_iterator.designation}: #{schedule_iterator.day} --> #{schedule_iterator.day + 7.days}"
      end
      schedule_iterator = schedule_iterator.next
    end
  end

  private

  def delay_all_season_schedules_day
    current_season = self.edition.season
    schedule_iterator = self.next
    # while next schedule exist AND is still on the same season
    # so I can continue iteration
    if schedule_iterator.present?
      if schedule_iterator.next.present?
        if schedule_iterator.next.edition.season == current_season
          # take the next schedule day to the current schedule
          schedule_iterator.update(day: schedule_iterator.next.day)
        else
          # .next exist AND next season != current_season
          # Add 7 days to the last schedule of the season
          schedule_iterator.update(day: schedule_iterator.day + 7)
        end
      else
        # It is the last schedule record
        # Add 7 days to the last schedule of the season
        schedule_iterator.update(day: schedule_iterator.day + 7)
      end
    end
  end

  def check_results_update
    Rails.logger.info "######## check_results_update"
    if games.flat_map(&:results).any?{|r| r.saved_change_to_attribute?(:mark) }
      Rails.logger.info "######## Un ou plusieurs Result#mark ont été mis à jour pour le Schedule id:#{id}"
      save_new_ranking_data
    end
  end

  def save_new_ranking_data
    logger.info "$$$$$$$ save_new_ranking_data $$$$$$$$"

    edition.rankings.create!(
      data: Competitions::Championship.new(edition: edition).ranking_datas
    )
  end

end
