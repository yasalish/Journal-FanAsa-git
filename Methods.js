function numJobs()
{
    var num=0
    for (var i = 0; i < jobs.length; i++) {
        var obj = jobs[i];
        if(obj.finished==0)
        {
            num++;
        }

    }
    return(num);
}
function retJobs()
{
    var jobList=[];
    for (var i = 0; i < jobs.length; i++) {
        var obj = jobs[i];
        if(obj.finished==0)
        {
            jobList.push(obj.type)
        }

    }
    return(jobList)
}
function retStylist()
{
    var stylistList = [];
    for (var i = 0; i < jobs.length; i++) {
        var obj = jobs[i];
        if(obj.finished==0)
        {
            stylistList.push(obj.stylist)
        }
    }
    return(stylistList)
}
function retCustomers()
{
    var num=0;
    var customerList = [];
    for (var i = 0; i < jobs.length; i++) {
        var obj = jobs[i];
        if(obj.finished==0)
        {
            customerList.push(obj.customer)
        }
    }
    return(customerList)

}

function retName(code)
{
    for (var i = 0; i < myData.length; i++) {
          var obj = myData[i];
          if(obj.code == code)
          {
              return(obj.name)
          }
    }
    return("unknown")
}
