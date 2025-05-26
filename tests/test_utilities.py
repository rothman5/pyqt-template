import threading
from time import sleep
from typing import Any
import unittest
from app.utilities.singleton import Singleton


class DummySingleton1(metaclass=Singleton):
    def __init__(self, value: int = 0) -> None:
        sleep(0.01)
        self.value = value


class DummySingleton2(metaclass=Singleton):
    def __init__(self, value: int = 0) -> None:
        sleep(0.01)
        self.value = value


class DummySingleton3(metaclass=Singleton):
    pass


class DummySingleton4(metaclass=Singleton):
    pass


class TestSingleton(unittest.TestCase):

    def test_singleton_instance(self) -> None:
        a = DummySingleton1(10)
        b = DummySingleton1(20)

        self.assertIs(a, b, "Singleton instances should be the same.")
        self.assertEqual(a.value, 10, "Singleton should retain the first value set.")
        self.assertEqual(b.value, 10, "Singleton should retain the first value set.")

    def test_singleton_thread_safety(self) -> None:
        lock = threading.Lock()
        instances: dict[type[Any], set[Any]] = {DummySingleton3: set(), DummySingleton4: set()}

        def create_instance(cls: type[Any]) -> None:
            instance = cls()
            with lock:
                instances[cls].add(instance)

        nthreads = 100
        threads = []
        for _ in range(nthreads):
            threads.append(threading.Thread(target=create_instance, args=(DummySingleton3,)))
            threads.append(threading.Thread(target=create_instance, args=(DummySingleton4,)))

        for thread in threads:
            thread.start()
        for thread in threads:
            thread.join()

        for cls, class_instances in instances.items():
            self.assertEqual(len(class_instances), 1, f"{cls.__name__} should only have one instance.")


if __name__ == "__main__":
    unittest.main()
