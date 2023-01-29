function sendReqACommnad()
{
    rcount=0
    rdata=""
    print("sendReqACommnad")
    var command="02-00-01-21-20"
    serial.onWriteData(command)
}
function sendAntiCollisionCommnad()
{
    print("sendAntiCollisionCommnad")

    if(rcount===1 && rdata.length===14 && rdata.substr(8,2)==="04")
        {
            var command="02-00-01-23-22"
            serial.onWriteData(command)
        }
        else
        {
            rcount=0
            sendReqACommnad()
        }
}
function sendSelectCommand()
{
    print("sendSelectCommand")
    if(rcount==2 && rdata.length===18)
        {
            var UID=rdata.substr(8,8)
            print("UID >",UID)
            var command="02-00-05-24-"
            command = command+UID
            command = command+calculateXOR(command)
            print(command)
            serial.onWriteData(command)
        }
        else
        {
            rcount=0
            sendReqACommnad()
        }
}
function sendAuthKeyB()
{
    print("sendAuthKeyB")
    if(rcount==3 && rdata.length===12 && rdata.substr(8,2)==="08")
        {
                var command="02-00-09-30-04-"
                command = command+keys[0]+"-05"
                command = command+calculateXOR(command)
                print(command)
                serial.onWriteData(command)
        }
        else
        {
            rcount=0
            sendReqACommnad()
        }
}
function readMifare()
{
    print("readMifare")
    if(rcount==4 && rdata.length===10 && rdata.substr(6,2)==="00")
        {
                var command="02-00-02-27-"
                command = command+"05"
                command = command+calculateXOR(command)
                print(command)
                serial.onWriteData(command)
        }
        else
        {
            rcount=0
            rdata=""
            sendReqACommnad()
       }
}
function writeMifare(code)
{
    print("writeMifare")
    if(rcount==5 && rdata.length===42 && rdata.substr(4,2)==="11" && rdata.substr(6,2)==="00")
        {
                var command="02-00-12-28-"
                command = command+"05-"
                var st="00000000000000000000000000000000"
                var n=code.length
                var index=st.length-n
                var str=st.slice(0,index)+code
                command = command+str
                command=command+calculateXOR(command)
                print(command)
                serial.onWriteData(command)
        }
        else
        {
            rcount=0
            rdata=""
            sendReqACommnad()
        }
}
function confirmWriteCode()
{
    if(rcount==6 && rdata.length===10 && rdata.substr(6,2)==="00")
        {
                return(true);
        }
        else
        {
            rcount=0
            rdata=""
            sendReqACommnad()
            return(false)
       }
}

function calculateXOR(st)
{
    var str=""
    for(var i=0;i<st.length;i++)
        if(st[i]!=='-')
            str +=st[i]
    print(str)
    var n=str.length
    var byt=[]
    for(i=2;i<n;i+=2)
       byt.push(str.substr(i,2))
    print(byt)
    var x=0
    for(i=0;i<byt.length;i++)
    {
        var y =parseInt(byt[i],16)
        x = x^y
    }
    print(x)
    var hexString = x.toString(16)
    return(hexString)
}

function retStylistCode()
{
    print("retStylistCode")
    if(rcount==5 && rdata.length===42 && rdata.substr(4,2)==="11" && rdata.substr(6,2)==="00")
        {
                var st=rdata.slice(8,40)
                print(st);
                var str=""
                for(var i=0;i<st.length;i++)
                    if(st[i]!=='0')
                        str +=st[i]
                return(str)
        }
        else
        {
            rcount=0
            rdata=""
        }
}
