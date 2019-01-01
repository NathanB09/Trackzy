class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise
  accepts_nested_attributes_for :exercise, allow_destroy: true, reject_if: proc { |attr| attr['name'].blank? && attr['sets'].blank? && attr['reps'].blank? }
end
