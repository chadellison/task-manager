require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers
  def test_can_create_a_task
    data = {
      title:       "some title",
      description: "some description"
    }

    task_manager.create(data)

    task = task_manager.all.last

    assert task.id
    assert_equal "some title", task.title
    assert_equal "some description", task.description
  end

  def test_it_calls_all_tasks

    data1 = {
      title:       "some title",
      description: "some description"
    }
    data2 = {
      title:       "another title",
      description: "another description"
    }

    task_manager.create(data1)
    task_manager.create(data2)

    tasks = task_manager.all
    assert_equal Task, tasks.sample.class
    assert_equal 2, tasks.count
    assert_equal "some title", tasks.first.title
    assert_equal "another description", tasks.last.description
  end

  def test_it_finds_a_task_from_id
    data1 = {
      title:       "some title",
      description: "some description"
    }
    data2 = {
      title:       "another title",
      description: "another description"
    }

    task_manager.create(data1)
    task_manager.create(data2)

    task1 = task_manager.find(1)
    task2 = task_manager.find(2)

    assert_equal "some title", task1.title
    assert_equal "another description", task2.description
  end

  def test_update_alters_an_existing_task
    data1 = {
      title:       "some title",
      description: "some description"
    }

    data2 = {
      title:       "another title",
      description: "another description"
    }

    task_manager.create(data1)
    task = task_manager.find(1)

    assert_equal "some title", task.title
    assert_equal "some description", task.description

    task_manager.update(data2, 1)
    task = task_manager.find(1)
    assert_equal "another title", task.title
  end

  def test_it_deletes_a_task_from_its_id
    data1 = {
      title:       "some title",
      description: "some description"
    }

    data2 = {
      title:       "another title",
      description: "another description"
    }

    task_manager.create(data1)
    task_manager.create(data2)

    tasks = task_manager.all

    assert_equal 2, task_manager.all.count
    assert_equal "some title", tasks[0].title

    task_manager.delete(1)

    tasks = task_manager.all

    assert_equal 1, task_manager.all.count
    assert_equal "another title", tasks[0].title

    assert_equal "another title", task_manager.find(2).title
  end
end
