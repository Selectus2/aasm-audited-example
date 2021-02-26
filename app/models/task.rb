class Task < ApplicationRecord
  audited

  audited only: :status

  include AASM

  aasm column: :status do
    state :draft, initial: true
    state :scheduled
    state :started
    state :canceled
    state :delayed
    state :completed
    state :deleted

    event :schedule do
        transitions from: :draft, to: :scheduled
    end

    event :start do
        transitions from: :scheduled, to: :started
    end

    event :delay do
        transitions from: :scheduled, to: :delayed
    end

    event :complete do
        transitions from: [:started, :delayed], to: :completed
    end

    event :destroy do
        transitions from: [:draft,:scheduled, :started, :delayed, :completed], to: :deleted
    end
  end

  def destroyed
    self.audits.last.undo
  end
end
