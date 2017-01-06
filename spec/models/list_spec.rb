require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do
      list = List.create(name: "Chores")
      task1 = Task.create(complete: false, list_id: list.id)
      task2 = Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should snooze each task by 1 hour' do
      list = List.create(name: "Chores")
      task_deadline = Time.now
      task1 = Task.create(deadline: task_deadline, list_id: list.id)
      task2 = Task.create(deadline: task_deadline, list_id: list.id)
      task3 = Task.create(deadline: task_deadline, list_id: list.id)
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(task_deadline + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it 'should return the sum of all the task durations' do
      list = List.create(name: "Chores")
      task1 = Task.create(duration: 50, list_id: list.id)
      task2 = Task.create(duration: 150, list_id: list.id)
      expect(list.total_duration).to eq(200)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of incomplete tasks' do
      list = List.create(name: "Chores")
      task1 = Task.create(complete: true, list_id: list.id)
      task2 = Task.create(complete: false, list_id: list.id)
      task3 = Task.create(complete: false, list_id: list.id)
      expect(list.incomplete_tasks.length).to eq(2)
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of incomplete tasks' do
      list = List.create(name: "Chores")
      task1 = Task.create(favorite: true, list_id: list.id)
      task2 = Task.create(favorite: false, list_id: list.id)
      task3 = Task.create(favorite: false, list_id: list.id)
      expect(list.favorite_tasks.length).to eq(1)
    end
  end
end
