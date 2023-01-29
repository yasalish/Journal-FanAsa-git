#include "serialport.h"
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>


SerialPort::SerialPort(QObject *parent):QObject(parent)
{

    rfid = new QSerialPort(this);
    bool result=connect(rfid, &QSerialPort::readyRead, this, &SerialPort::onReadData);
    qDebug()<<"@@@@@@@@@@@@@ New Serial Port @@@@@@@@@@@@@@@ "<<result;

}

SerialPort::~SerialPort()
{
    delete rfid;
    qDebug()<<"@@@@@@@@@@@@@  Serial Port is deleted @@@@@@@@@@@@@@@ ";

}

void SerialPort::onReadData()
{
    if(rfid->bytesAvailable()>0){
        QByteArray rdata = rfid->readAll();
        qDebug()<<"***> Read Data = "<<rdata<<endl;
        QString DataAsString(rdata.toHex());
        //qDebug()<<"***> Read Data = "<<DataAsString<<endl;
        emit dataReceived(DataAsString);
    }
}

void SerialPort::onWriteData(QString data){
    data.replace("-","");
    qDebug()<<"1***> Write Data = "<<data;
    QByteArray cmd = QByteArray::fromHex(data.toUtf8());
    //qDebug()<<"2***> Write Data = "<<cmd<<endl;
    rfid->write(cmd);
}

void SerialPort::close()
{
    rfid->close();
    qDebug()<<"Close the serial port**\n";
}

void SerialPort::open(QString port)
{
    qDebug()<<"Open the serial port\t"<<port;
    for(auto info: QSerialPortInfo::availablePorts()){
        qDebug()<<info.portName()<<info.description()<<info.manufacturer();        
    }    
    //portInfo.portName()=port;
    //qDebug()<<"#################  "<<portInfo.portName();
    rfid->setPortName(port);
    rfid->setBaudRate(QSerialPort::Baud115200);
    rfid->setDataBits(QSerialPort::Data8);
    rfid->setParity(QSerialPort::NoParity);
    rfid->setStopBits(QSerialPort::OneStop);
    rfid->setFlowControl(QSerialPort::NoFlowControl);

    if(rfid->open(QSerialPort::ReadWrite))
        qDebug()<<"Connected to "<< portInfo.manufacturer()<< " on " << portInfo.portName();
    else
    {
        qCritical()<<"Serial Port error: " << rfid->errorString();
        rfid->open(QSerialPort::ReadWrite);
    }

}




