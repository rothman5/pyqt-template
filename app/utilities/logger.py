import logging
import sys
import traceback
from enum import StrEnum

from app.utilities import PROJECT_PATH
from app.utilities.singleton import Singleton


class ANSI(StrEnum):
    """ANSI color codes for terminal output."""

    BOLD = "\033[1m"
    YELLOW = "\033[33m"
    GREEN = "\033[32m"
    RED = "\033[31m"
    PURPLE = "\033[35m"
    ORANGE = "\033[38;5;208m"
    GRAY = "\x1b[38;5;248m"
    WHITE = "\033[97m"
    LIGHT_RED = "\033[38;5;210m"
    RESET = "\033[0m"


class ColoredFormatter(logging.Formatter):
    """Logging colored formatter with customizable text and date format."""

    COLORS = {
        logging.DEBUG: ANSI.WHITE + ANSI.BOLD,
        logging.INFO: ANSI.GREEN + ANSI.BOLD,
        logging.WARNING: ANSI.YELLOW + ANSI.BOLD,
        logging.ERROR: ANSI.RED + ANSI.BOLD,
        logging.CRITICAL: ANSI.LIGHT_RED + ANSI.BOLD,
    }

    def format(self, record: logging.LogRecord) -> str:
        """
        Format the log record with colors and custom formatting.

        Args:
            record (logging.LogRecord): The log record to format.

        Returns:
            str: The formatted log message with colors.
        """
        # Create a copy to avoid modifying the original record
        rc = logging.makeLogRecord(record.__dict__)
        color = self.COLORS.get(rc.levelno, ANSI.RESET)
        rc.levelname = f"{color}{rc.levelname:>5.5s}{ANSI.RESET}"
        rc.threadName = f"{ANSI.GRAY}{rc.threadName:<10.10s}{ANSI.RESET}"
        module = f"{ANSI.GRAY}{rc.module}{ANSI.RESET}"
        lineno = f"{ANSI.GRAY}{rc.lineno:<4d}{ANSI.RESET}"
        rc.module = f"{module}:{lineno}"
        return super().format(rc)


class LogLevelFilter(logging.Filter):
    """Filter to modify log level names consistently."""

    LEVEL_MAPPINGS = {"WARNING": "WARN", "CRITICAL": "CRIT"}

    def filter(self, record: logging.LogRecord) -> bool:
        """
        Filter to modify log level names in the log record.

        Args:
            record (logging.LogRecord): The log record to filter.

        Returns:
            bool: True if the record should be logged, False otherwise.
        """
        if record.levelname in self.LEVEL_MAPPINGS:
            record.levelname = self.LEVEL_MAPPINGS[record.levelname]
        return True


class Log(metaclass=Singleton):
    """
    A singleton logger that logs to both the console and a log file.
    """

    DATE_FMT = "%Y-%m-%d %H:%M:%S"
    FILE_FMT = "[%(asctime)s on %(threadName)-10s @ %(module)s:%(lineno)-4d] %(levelname)5.5s: %(message)s"
    TEXT_FMT = "[%(asctime)s on %(threadName)s @ %(module)s] %(levelname)s: %(message)s"

    def __init__(self, name: str = "App", log_file: str = "debug.log") -> None:
        # Only initialize once due to singleton pattern
        if hasattr(self, "_initialized"):
            return

        self._name = name
        self._file = PROJECT_PATH / log_file

        # Create the logger
        self._log = logging.getLogger(self._name)
        self._log.setLevel(logging.DEBUG)

        # Prevent duplicate handlers if logger already exists
        if not self._log.handlers:
            self._setup_logging()

        self._initialized = True
        self._log.info("The logger has been initialized.")

    def debug(self, message: str, *args, **kwargs) -> None:
        """Log a debug message."""
        self._log.debug(message, *args, **kwargs)

    def info(self, message: str, *args, **kwargs) -> None:
        """Log an info message."""
        self._log.info(message, *args, **kwargs)

    def warning(self, message: str, *args, **kwargs) -> None:
        """Log a warning message."""
        self._log.warning(message, *args, **kwargs)

    def warn(self, message: str, *args, **kwargs) -> None:
        """Alias for warning (deprecated in logging module but kept for compatibility)."""
        self.warning(message, *args, **kwargs)

    def error(self, message: str, *args, **kwargs) -> None:
        """Log an error message."""
        self._log.error(message, *args, **kwargs)

    def critical(self, message: str, *args, **kwargs) -> None:
        """Log a critical message."""
        self._log.critical(message, *args, **kwargs)

    def exception(self, message: str, *args, **kwargs) -> None:
        """Log an exception with traceback."""
        self._log.exception(message, *args, **kwargs)

    def close(self) -> None:
        """Close all handlers and clean up resources."""
        # Create a copy to avoid modification during iteration
        handlers = self._log.handlers[:]
        for handler in handlers:
            handler.close()
            self._log.removeHandler(handler)

    def _setup_logging(self) -> None:
        """Set up file and console handlers."""
        self._add_file_handler()
        self._add_console_handler()

    def _add_file_handler(self) -> None:
        """Add file handler for logging to file."""
        try:
            # Create the log file if it doesn't exist
            self._file.touch(exist_ok=True)
        except (OSError, PermissionError):
            traceback.print_exc()
        else:
            # Create file handler
            self._file_handler = logging.FileHandler(self._file, "a", "utf-8")
            self._file_handler.setLevel(logging.DEBUG)
            self._file_handler.addFilter(LogLevelFilter())

            # Create formatter
            formatter = logging.Formatter(self.FILE_FMT, self.DATE_FMT)
            self._file_handler.setFormatter(formatter)

            # Add handler to logger
            self._log.addHandler(self._file_handler)

    def _add_console_handler(self) -> None:
        """Add console handler for colored output."""
        # Create console handler
        self._console_handler = logging.StreamHandler(sys.stdout)
        self._console_handler.setLevel(logging.DEBUG)
        self._console_handler.addFilter(LogLevelFilter())

        # Use colored formatter for console
        formatter = ColoredFormatter(self.TEXT_FMT, self.DATE_FMT)
        self._console_handler.setFormatter(formatter)

        # Add handler to logger
        self._log.addHandler(self._console_handler)


if __name__ == "__main__":
    log1 = Log()
    log2 = Log()

    assert id(log1) == id(log2), "Log instances are not the same!"

    log1.debug("This is a debug message")
    log1.info("This is an info message")
    log1.warning("This is a warning message")
    log1.error("This is an error message")
    log1.critical("This is a critical message")
    try:
        raise ValueError("Test exception for logging")
    except ValueError:
        log1.exception("Caught an exception")

    log2.debug("This is a debug message")
    log2.info("This is an info message")
    log2.warning("This is a warning message")
    log2.error("This is an error message")
    log2.critical("This is a critical message")
    try:
        raise ValueError("Test exception for logging")
    except ValueError:
        log2.exception("Caught an exception")

    log1.close()
    log2.close()
