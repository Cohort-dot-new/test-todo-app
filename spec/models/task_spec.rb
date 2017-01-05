require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'toggle_complete!' do
    it 'should switch complete to false if it began as true' do
      task = Task.new(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it 'should switch complete to true if it began as false' do
      task = Task.new(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe 'toggle_favorite!' do
    it 'should switch favorite to false if it began as true' do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it 'should switch favorite to true if it began as false' do
      task = Task.new(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe 'overdue?' do
    it 'should return true if deadline is earlier than now' do
      task = Task.new(deadline: 1.day.ago)
      expect(task.overdue?).to eq(true)
    end

    it 'should return false if deadline is later than now' do
      task = Task.new(deadline: 1.day.from_now)
      expect(task.overdue?).to eq(false)
    end
  end

  describe 'increment_priority!' do
    it 'should increase priority by 1' do
      task = Task.new(priority: 9)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end

    it 'should not increase priority beyond 10' do
      task = Task.new(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe 'decrement_priority!' do
    it 'should decrease priority by 1' do
      task = Task.new(priority: 2)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end

    it 'should not decrease priority below 1' do
      task = Task.new(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe 'snooze_hour!' do
    it 'should push deadline by one hour' do
      task_deadline = Time.now
      task = Task.new(deadline: task_deadline)
      task.snooze_hour!
      expect(task.deadline).to eq(task_deadline + 1.hour)
    end
  end
end
