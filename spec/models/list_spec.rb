require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do
      list = List.new(name: "Chores")
      list.save
      task1 = Task.new(complete: false, list_id: list.id)
      task1.save
      task2 = Task.new(complete: false, list_id: list.id)
      task2.save
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end
end
