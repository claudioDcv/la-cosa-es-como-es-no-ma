function ideaXHR() {
// Get all users
var url  = "http://localhost:8080/api/v1/users";
var xhr  = new XMLHttpRequest()
xhr.open('GET', url, true)
xhr.onload = function () {
	var users = JSON.parse(xhr.responseText);
	if (xhr.readyState == 4 && xhr.status == "200") {
		console.table(users);
	} else {
		console.error(users);
	}
}
xhr.send(null);


// Get a user
var url  = "http://localhost:8080/api/v1/users";
var xhr  = new XMLHttpRequest()
xhr.open('GET', url+'/1', true)
xhr.onload = function () {
	var users = JSON.parse(xhr.responseText);
	if (xhr.readyState == 4 && xhr.status == "200") {
		console.table(users);
	} else {
		console.error(users);
	}
}
xhr.send(null);


// Post a user
var url = "http://localhost:8080/api/v1/users";

var data = {};
data.firstname = "John";
data.lastname  = "Snow";
var json = JSON.stringify(data);

var xhr = new XMLHttpRequest();
xhr.open("POST", url, true);
xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
xhr.onload = function () {
	var users = JSON.parse(xhr.responseText);
	if (xhr.readyState == 4 && xhr.status == "201") {
		console.table(users);
	} else {
		console.error(users);
	}
}
xhr.send(json);


// Update a user
var url = "http://localhost:8080/api/v1/users";

var data = {};
data.firstname = "John2";
data.lastname  = "Snow2";
var json = JSON.stringify(data);

var xhr = new XMLHttpRequest();
xhr.open("PUT", url+'/12', true);
xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
xhr.onload = function () {
	var users = JSON.parse(xhr.responseText);
	if (xhr.readyState == 4 && xhr.status == "200") {
		console.table(users);
	} else {
		console.error(users);
	}
}
xhr.send(json);


// Delete a user
var url = "http://localhost:8080/api/v1/users";
var xhr = new XMLHttpRequest();
xhr.open("DELETE", url+'/12', true);
xhr.onload = function () {
	var users = JSON.parse(xhr.responseText);
	if (xhr.readyState == 4 && xhr.status == "200") {
		console.table(users);
	} else {
		console.error(users);
	}
}
xhr.send(null);
};

// POST
window.XHRCreate = function(opts) {
	/*
	{
		url: '',
		data: {},
		success: function() {},
		error: function() {},
	}
	*/
	// Get a user
	var url = opts.url;
	var data = opts.data;
	var json = JSON.stringify(data);

	var xhr = new XMLHttpRequest();
	xhr.open("POST", url, true);
	xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
	xhr.setRequestHeader('X-CSRFToken', data.csrfmiddlewaretoken);
	xhr.onload = function () {
		var model = JSON.parse(xhr.responseText);
		if (xhr.readyState == 4 && xhr.status == "201") {
			opts.success(model)
		} else {
			opts.error(model);
		}
	}
	xhr.send(json);
};

window.XHRUpdate = function(opts) {
	// Update a user
	var url = opts.url;
	var data = opts.data;
	var json = JSON.stringify(data);

	var xhr = new XMLHttpRequest();
	xhr.open("PUT", url + (data.id || data.pk) + '/', true);
	xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
	xhr.setRequestHeader('X-CSRFToken', data.csrfmiddlewaretoken);
	xhr.onload = function () {
		var model = JSON.parse(xhr.responseText);
		if (xhr.readyState == 4 && xhr.status == "200") {
			opts.success(model)
		} else {
			opts.error(model);
		}
	}
	xhr.send(json);
};

window.XHRDelete = function(opts) {
	// Update a user
	var url = opts.url;
	var data = opts.data;
	var xhr = new XMLHttpRequest();
	xhr.open("DELETE", url + (data.id || data.pk) + '/', true);
	xhr.setRequestHeader('X-CSRFToken', data.csrfmiddlewaretoken);
	xhr.onload = function () {
		var model = { id: (data.id || data.pk) };
		if (xhr.responseText) {
			model = JSON.parse(xhr.responseText);
		}
		if (xhr.readyState == 4 && xhr.status == "204") {
			opts.success(model)
		} else {
			opts.error(model);
		}
	}
	xhr.send(null);
};
