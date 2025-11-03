import unittest
from io import StringIO
import sys
from todo import Task, TaskPool

class TestTaskPool(unittest.TestCase):
    def setUp(self):
        self.pool = TaskPool()

    def test_add_task(self):
        t = Task("New Task")
        self.pool.add_task(t)
        self.assertEqual(len(self.pool.tasks), 1)
        self.assertEqual(self.pool.tasks[0].title, "New Task")

    def test_get_open_tasks(self):
        self.pool.populate()
        opens = [t.title for t in self.pool.get_open_tasks()]
        self.assertIn("Wire CI", opens)
        self.assertIn("Build Docker image", opens)

    def test_get_done_tasks(self):
        self.pool.populate()
        dones = [t.title for t in self.pool.get_done_tasks()]
        self.assertIn("Design data model", dones)
        self.assertIn("Implement API", dones)
        self.assertIn("Write unit tests", dones)

if __name__ == "__main__":
    suite = unittest.defaultTestLoader.loadTestsFromTestCase(TestTaskPool)
    buf = StringIO()
    runner = unittest.TextTestRunner(stream=buf, verbosity=2)
    result = runner.run(suite)
    lines = buf.getvalue().splitlines()
    for line in lines:
        if line.strip().endswith(" ... ok"):
            print(line.strip())
    sys.exit(0 if result.wasSuccessful() else 1)
