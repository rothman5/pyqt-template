from typing import Any, ClassVar, TypeVar

T = TypeVar("T")


class Singleton(type):
    """
    A metaclass that implements the Singleton design pattern.
    Ensures that only one instance of a class using this metaclass exists.
    """

    _instances: ClassVar[dict[type[Any], Any]] = {}

    def __call__(cls: type[T], *args, **kwargs) -> T:
        """
        Returns the existing instance of the class, or creates one if it doesn't exist.

        This method overrides the default `__call__` behavior to implement
        the Singleton pattern. It checks if an instance of the class already exists
        in the `_instances` dictionary. If not, it creates a new instance by calling
        the superclass's `__call__` method, stores it in the `_instances` dictionary,
        and returns it. If an instance already exists, it simply returns the existing
        instance.

        Args:
            cls: The class being instantiated.
            *args: Positional arguments to pass to the class constructor.
            **kwargs: Keyword arguments to pass to the class constructor.

        Returns:
            type: The singleton instance of the class.
        """
        if cls not in Singleton._instances:
            Singleton._instances[cls] = super().__call__(*args, **kwargs)
        return Singleton._instances[cls]
