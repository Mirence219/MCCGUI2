import sys
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl
from PySide6.QtQuickControls2 import QQuickStyle

QQuickStyle.setStyle("Basic")
app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.load(QUrl.fromLocalFile("src/qml/Main.qml"))

sys.exit(app.exec())
