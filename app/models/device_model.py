from typing import Optional, Union

from PySide6.QtCore import (
    QAbstractListModel,
    QByteArray,
    QModelIndex,
    QObject,
    QPersistentModelIndex,
    Qt,
    Slot,
)
from PySide6.QtSerialPort import QSerialPortInfo

from app.models.device import Device

ModelIndex = Union[QModelIndex, QPersistentModelIndex]
ModelData = Union[str, int, bool, Device]


class DeviceModel(QAbstractListModel):
    NameRole = Qt.ItemDataRole.UserRole + 1
    PortRole = Qt.ItemDataRole.UserRole + 2
    BaudRole = Qt.ItemDataRole.UserRole + 3
    DeviceRole = Qt.ItemDataRole.UserRole + 4
    ConnectedRole = Qt.ItemDataRole.UserRole + 5

    def __init__(self, parent: Optional[QObject] = None) -> None:
        super().__init__(parent)
        self._devices: list[Device] = []

    @Slot(str, str, int, result=bool)
    def add_device(self, name: str, port: str, baud: int) -> bool:
        print(name, port, baud)
        if any(device.name == name for device in self._devices):
            return False

        self.beginInsertRows(QModelIndex(), len(self._devices), len(self._devices))

        device = Device(name, port, baud, parent=self)
        device.port_changed.connect(lambda: self._device_changed(device))
        device.baud_changed.connect(lambda: self._device_changed(device))
        device.connection_toggled.connect(lambda: self._device_changed(device))

        self._devices.append(device)
        self.endInsertRows()
        return True

    @Slot(int, result=bool)
    def remove_device(self, index: int) -> bool:
        if 0 <= index < len(self._devices):
            self.beginRemoveRows(QModelIndex(), index, index)
            device = self._devices.pop(index)
            device.disconnect()
            device.deleteLater()
            self.endRemoveRows()
            return True
        return False

    @Slot(int, result=QObject)
    def get_device(self, index: int) -> Optional[Device]:
        print(self._devices, index)
        if 0 <= index < len(self._devices):
            return self._devices[index]
        return None

    def data(self, index: ModelIndex, role: int = Qt.ItemDataRole.DisplayRole) -> Optional[ModelData]:
        if not index.isValid() or (index.row() < 0) or (index.row() >= len(self._devices)):
            return None

        device = self._devices[index.row()]
        if (role == self.NameRole) or (role == Qt.ItemDataRole.DisplayRole):
            return device.get_name()
        elif role == self.PortRole:
            return device.get_port()
        elif role == self.BaudRole:
            return device.get_baud()
        elif role == self.ConnectedRole:
            return device.is_connected()
        elif role == self.DeviceRole:
            return device
        return None

    def roleNames(self) -> dict[int, QByteArray]:
        return {
            self.NameRole: QByteArray(b"name"),
            self.PortRole: QByteArray(b"port"),
            self.BaudRole: QByteArray(b"baud"),
            self.DeviceRole: QByteArray(b"device"),
            self.ConnectedRole: QByteArray(b"connected"),
        }

    def rowCount(self, parent: ModelIndex = QModelIndex()) -> int:
        return len(self._devices)

    def _device_changed(self, device: Device) -> None:
        try:
            index = self._devices.index(device)
        except ValueError:
            return
        else:
            model_index = self.createIndex(index, 0)
            self.dataChanged.emit(model_index, model_index)


class PortModel(QAbstractListModel):
    PortRole = Qt.ItemDataRole.UserRole + 1
    DescRole = Qt.ItemDataRole.UserRole + 2

    def __init__(self, parent: Optional[QObject] = None) -> None:
        super().__init__(parent)
        self._ports: list[QSerialPortInfo] = []

    @Slot()
    def refresh_ports(self) -> None:
        ports = QSerialPortInfo.availablePorts()
        changed = any(p1.portName() != p2.portName() for p1, p2 in zip(ports, self._ports))
        if (len(ports) == len(self._ports)) or changed:
            self.beginResetModel()
            self._ports = ports
            self.endResetModel()

    @Slot(result=list[str])
    def get_port_names(self) -> list[str]:
        return [port.portName() for port in self._ports]

    def data(self, index: ModelIndex, role: int = Qt.ItemDataRole.DisplayRole) -> Optional[ModelData]:
        if not index.isValid() or (index.row() < 0) or (index.row() >= len(self._ports)):
            return None

        port_info = self._ports[index.row()]
        if (role == self.PortRole) or (role == Qt.ItemDataRole.DisplayRole):
            return port_info.portName()
        elif role == self.DescRole:
            desc = port_info.description()
            return f"{port_info.portName()} - {desc}" if desc else port_info.portName()
        return None

    def roleNames(self) -> dict[int, QByteArray]:
        return {
            self.PortRole: QByteArray(b"port"),
            self.DescRole: QByteArray(b"description"),
        }

    def rowCount(self, parent: ModelIndex = QModelIndex()) -> int:
        return len(self._ports)
