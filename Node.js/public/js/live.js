var add_new_image = function (link, client_date, location) {
  var src = document.querySelector('.col-md-6');
  var new_image = src.cloneNode(true);
  new_image.querySelector('h3').innerHTML = client_date;
  new_image.querySelector('p').innerHTML = location;
  new_image.querySelector('img').src = link;
  document.querySelector('.container-fluid').appendChild(new_image);
};

var socket = io(); // TIP: io() with no args does auto-discovery
socket.on('connect', function () { // TIP: you can avoid listening on `connect` and listen on events directly too!
  console.log('WSS Connected');

  socket.on('image', function (image) { // TIP: you can avoid listening on `connect` and listen on events directly too!
    console.log('New Image');
    console.log(image);
    var attachment = Object.keys(image.doc._attachments)[0]
    var url = "/image/" + image.doc._id + "/" + attachment;
    console.log(url);
    add_new_image(url, image.doc.clientDate, 'latitude: ' 
                  + image.doc.latitude + ', longitude: ' 
                  + image.doc.longitude + ', altitude: ' 
                  + image.doc.altitude);
  });
});
