/*
var IPAddress=ipAddress
var bASE="http://"+IPAddress+":5000/"
var bASE1=bASE+"jobs";
var bASE2=bASE+"stylists";
var bASE3=bASE+"login";
var bASE4=bASE+"logoff";
*/
function readConfigFile() {
    var xhr = new XMLHttpRequest;
    var configaddress = "Configs.json";
    console.log(configaddress);
    xhr.open("GET", configaddress);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            var response = xhr.responseText;
            print(response)
            var js = JSON.parse(response)
            ipAddress=js["IPAddr"]
            print(ipAddress)
        }
    };
    xhr.send();
}

function writeConfigFile(text) {
    var xhr = new XMLHttpRequest();
    var configaddress = "Configs.json";
    console.log(configaddress);
    xhr.open("PUT", configaddress,false);
    xhr.send(text);
    print(xhr.status);
    return xhr.status;
}

function request(verb,bASE,endpoint, obj, cb) {
    var xhr = new XMLHttpRequest();
    print(bASE + (endpoint?'/' + endpoint:''))
    xhr.onreadystatechange = function() {
        print('xhr: on ready state change: ' + xhr.readyState)
        if(xhr.readyState === XMLHttpRequest.DONE) {
            if(cb) {
                var res = JSON.parse(xhr.responseText.toString())
                cb(res);
                }
             }
     }
    xhr.open(verb, bASE + (endpoint?'/' + endpoint:''));
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.setRequestHeader('Accept', 'application/json');
    var data = obj?JSON.stringify(obj):''
    xhr.send(data)
}


//   Job Methods
function get_jobs(cb) {
    request('GET', bASE1 ,null, null, cb)
}

function get_job(id, cb) {
    request('GET', bASE1 ,id, null, cb)
}

function get_job_name(name, cb) {
    request('GET', bASE1 ,name, null, cb)
}

function update_job(id, entry, cb) {
    request('PUT', bASE1 ,id, entry, cb)
}

function assign_job(id, cb) {
    var endpoint="assign/"+id
    request('GET', bASE1 ,endpoint, null, cb)
}

function accept_job(id, cb) {
    var endpoint="accept/"+id
    request('GET', bASE1 ,endpoint, null, cb)
}

function finish_job(id, cb) {
    var endpoint="finish/"+id
    request('GET', bASE1 ,endpoint, null, cb)
}


//   Stylist Methods
function login_stylist(id,cb) {
    print(bASE3);
    request('GET', bASE3 ,id, null, cb);
}

function ready_stylist(name,cb) {
    request('GET', bASE3 ,name, null, cb)
}

function logoff_stylist(name,cb) {
    request('GET', bASE4 ,name, null, cb)
}

function get_stylists(cb) {
    request('GET', bASE2 ,null, null, cb)
}

function get_stylist(id, cb) {
    request('GET', bASE2 ,id, null, cb)
}

function get_stylist_jobs(id, cb) {
    var endpoint="jobs/"+id
    request('GET', bASE2 ,endpoint, null, cb)
}
