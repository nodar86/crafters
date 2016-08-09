class Event < ApplicationRecord
  has_and_belongs_to_many :users
  before_save :setGroupEvent

  validates :name, presence: true
  validates :startDate, presence: true
  validate :event_cant_start_in_past
  validates :maxPlayers, presence: true
  validates :maxPlayers, numericality: { only_integer: true }
  validates :playersInGroup, presence: true 
  validates :playersInGroup, numericality: { only_integer: true }
  validate :maxPlayers_has_to_be_dividable_by_playersInGroup

  def setGroupEvent
      self.groupEvent = (self.playersInGroup != 1)
  end

  def event_cant_start_in_past
    if startDate.present? && startDate < Date.today
      errors.add(:startDate, "Nem lehet a múltban")
    end
  end

  def maxPlayers_has_to_be_dividable_by_playersInGroup
    if maxPlayers % playersInGroup != 0
      errors.add(:playersInGroup, "A maximális játékosszám osztható kell legyen a csapatmérettel")
    end
  end
end
