# todo.py
from dataclasses import dataclass
from typing import List

@dataclass
class Task:
    title: str
    status: str = "ToDo"  # default; lecture uses “ToDo”
    completed: bool = False

    def mark_completed(self):
        self.completed = True
        self.status = "Done"

    def __repr__(self):
        return f"{self.title} - {self.status}"

    def __str__(self):
        return f"Task: {self.title}, Status: {self.status}"

class TaskPool:
    def __init__(self):
        self.tasks: List[Task] = []

    def populate(self):
        t1 = Task("Design data model", "ToDo")
        t2 = Task("Implement API", "ToDo")
        t3 = Task("Write unit tests", "ToDo")
        t4 = Task("Wire CI", "ToDo")
        t5 = Task("Build Docker image", "ToDo")
        t6 = Task("Update index.html", "ToDo")
        # mark first three completed
        for t in (t1, t2, t3):
            t.mark_completed()
        self.tasks = [t1, t2, t3, t4, t5, t6]

    def add_task(self, task: Task):
        self.tasks.append(task)

    def get_open_tasks(self) -> List[Task]:
        return [t for t in self.tasks if t.status == "ToDo"]

    def get_done_tasks(self) -> List[Task]:
        return [t for t in self.tasks if t.status == "Done"]

def main():
    pool = TaskPool()
    pool.populate()

    open_titles = [t.title for t in pool.get_open_tasks()]
    done_titles = [t.title for t in pool.get_done_tasks()]

    print("ToDo Tasks:")
    for title in open_titles:
        print(title)
    print("Done Tasks:")
    for title in done_titles:
        print(title)

if __name__ == "__main__":
    main()
