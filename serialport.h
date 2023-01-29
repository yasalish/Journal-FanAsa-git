#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QQuickItem>
#include <QSerialPortInfo>
#include <QtSerialPort/QSerialPort>

class SerialPort : public QObject
{
    Q_OBJECT

public:
    SerialPort(QObject *parent = 0);
    ~SerialPort();

public slots:
    void onReadData();
    void onWriteData(QString data);
    void open();
    void close();

signals:
       void receiveChanged();
       void readdataChanged();
       void dataReceived(QString data);

private:
    QSerialPort *rfid;
    QSerialPortInfo portInfo;
};

#endif // SERIALPORT_H
