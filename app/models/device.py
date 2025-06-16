from typing import Optional

from PySide6.QtCore import Property, QObject, Signal, Slot
from PySide6.QtSerialPort import QSerialPort


class Device(QObject):
    data_transmitted = Signal(int)
    data_received = Signal(bytes)
    error_occurred = Signal(str)
    port_changed = Signal(str)
    baud_changed = Signal(int)
    connection_toggled = Signal(bool)

    def __init__(
        self,
        name: str,
        portname: str,
        baudrate: int = 115200,
        *,
        parent: Optional[QObject] = None,
        databits: QSerialPort.DataBits = QSerialPort.DataBits.Data8,
        parity: QSerialPort.Parity = QSerialPort.Parity.NoParity,
        stopbits: QSerialPort.StopBits = QSerialPort.StopBits.OneStop,
        flowcontrol: QSerialPort.FlowControl = QSerialPort.FlowControl.NoFlowControl,
    ) -> None:
        super().__init__(parent)
        self._name = name
        self._port = portname
        self._baud = baudrate
        self._databits = databits
        self._parity = parity
        self._stopbits = stopbits
        self._flowcontrol = flowcontrol

        self._serial = QSerialPort(parent=self)
        self._serial.setPortName(self._port)
        self._serial.setBaudRate(self._baud)
        self._serial.setDataBits(self._databits)
        self._serial.setParity(self._parity)
        self._serial.setStopBits(self._stopbits)
        self._serial.setFlowControl(self._flowcontrol)
        self._serial.bytesWritten.connect(self._transmission_cb)
        self._serial.readyRead.connect(self._reception_cb)
        self._serial.errorOccurred.connect(self._error_cb)

    def get_name(self) -> str:
        return self._name

    def set_port(self, portname: str) -> None:
        if self._port == portname:
            return

        was_on = self._serial.isOpen()
        if was_on:
            self.disconnect()

        self._port = portname
        self._serial.setPortName(self._port)
        if was_on:
            self.connect()
        self.port_changed.emit(self._port)

    def get_port(self) -> str:
        return self._port

    def set_baud(self, baudrate: int) -> None:
        if (self._baud == baudrate) or (baudrate <= 0):
            return

        was_on = self._serial.isOpen()
        if was_on:
            self.disconnect()

        self._baud = baudrate
        self._serial.setBaudRate(self._baud)
        if was_on:
            self.connect()
        self.baud_changed.emit(self._baud)

    def get_baud(self) -> int:
        return self._baud

    def is_connected(self) -> bool:
        return self._serial.isOpen()

    name = Property(str, get_name, None, None, "Name", constant=True)
    port = Property(str, get_port, set_port, None, "Port", notify=port_changed)
    baud = Property(int, get_baud, set_baud, None, "Baud", notify=baud_changed)
    connected = Property(bool, is_connected, None, None, "Status", notify=connection_toggled)

    @Slot(result=bool)
    def connect(self) -> bool:
        if not self._serial.isOpen():
            status = self._serial.open(QSerialPort.OpenModeFlag.ReadWrite)
            self.connection_toggled.emit(status)
            if not status:
                err = f"Failed to open port {self._port}: {self._serial.errorString()}"
                self.error_occurred.emit(err)
            return status
        return True

    @Slot()
    def disconnect(self) -> None:
        if self._serial.isOpen():
            self._serial.close()
            self.connection_toggled.emit(False)

    @Slot()
    def toggle(self) -> None:
        if self._serial.isOpen():
            self.disconnect()
        else:
            self.connect()

    @Slot(bytes)
    def transmit(self, data: bytes) -> None:
        if self._serial.isOpen():
            self._serial.write(data)

    def _transmission_cb(self, nwritten: int) -> None:
        self.data_transmitted.emit(nwritten)

    def _reception_cb(self) -> None:
        data = self._serial.readAll().data()
        self.data_received.emit(bytes(data))

    def _error_cb(self, error: QSerialPort.SerialPortError) -> None:
        msg = self._serial.errorString()
        self.error_occurred.emit(msg)
