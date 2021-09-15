class Schedule < ApplicationRecord
  # attr_accessor :first_day
  belongs_to :edition
  has_many :games

  after_update :delay_all_season_schedules_day

  accepts_nested_attributes_for :games


  def next
    next_schedule = self.class.where("id > ?", id).first
    self.edition == next_schedule&.edition ? next_schedule : nil

  end

  def previous
    previous_schedule = self.class.where("id < ?", id).last
    self.edition == previous_schedule&.edition ? previous_schedule : nil
  end

  def season
    self.edition.season
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

end
