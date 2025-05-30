import sys

from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication

from app.utilities import QML_PATH

if __name__ == "__main__":
    app = QApplication(sys.argv)
    eng = QQmlApplicationEngine()

    eng.load(QML_PATH / "App.qml")
    if not eng.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
