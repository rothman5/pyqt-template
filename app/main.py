import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from app.tools.logger import Log
from app.tools.paths import QML_PATH


def main() -> None:
    if not QML_PATH.exists():
        raise FileNotFoundError(f"Failed to locate the QML file: {QML_PATH}")

    log = Log()
    app = QGuiApplication(sys.argv)
    eng = QQmlApplicationEngine()

    eng.load(QML_PATH)
    if not eng.rootObjects():
        raise RuntimeError("Failed to load the QML file.")

    try:
        sys.exit(app.exec())
    except KeyboardInterrupt:
        log.info("Closing... Bye!")
        sys.exit(0)
    except Exception:
        log.exception("An unexpected error occurred")
        sys.exit(1)


if __name__ == "__main__":
    main()
