#include "fileio.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>
 #include <QCoreApplication>

FileIO::FileIO(QObject *parent) :
    QObject(parent)
{

}

QString FileIO::read()
{
    mSource = qApp->applicationDirPath()+'/'+mSource;
    if (mSource.isEmpty()){
        emit error("source is empty");
        return QString();
    }
    QFile file(mSource);
    QString fileContent;
    if ( file.open(QIODevice::ReadOnly) ) {
        QString line;
        QTextStream t( &file );
        do {
            line = t.readLine();
            fileContent += line;
         } while (!line.isNull());
        file.close();
    } else {
        emit error("Unable to open the file");
        return QString();
    }
    qDebug() << "App path : " << qApp->applicationDirPath();
    return fileContent;
}


bool FileIO::write(const QString& data)
{
    mSource = qApp->applicationDirPath()+'/'+mSource;
    qDebug()<<mSource;
    if (mSource.isEmpty())
            return false;

        QFile file(mSource);
        if (!file.open(QFile::WriteOnly | QFile::Truncate))
            return false;

        QTextStream out(&file);
        out << data;
        qDebug()<<file.fileName();

        file.close();

        return true;
}
