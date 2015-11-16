clicking = function(){

 // var session = OT.initSession(apiKey, sessionID);

 $('#startSession').on('click', function (){
   console.log("session started");
   var session = OT.initSession(apiKey, sessionID);
   session.connect(token, function(error) {
     if (error) {
       console.log(error.message);
     } else {
     // This example assumes that a DOM element with the ID 'publisherElement' exists
       $('#startChat').on('click', function() {
        //  $('#myModal').modal('show');
       var publisherProperties = {width: 400, height:300, name:"Tim's stream"};

       publisher = OT.initPublisher('textchat', publisherProperties);

       session.publish(publisher);

       $('#endChat').on('click', function(){
         publisher.destroy();
       });
      });
      }

      session.on('streamCreated', function(event) {
      session.subscribe(event.stream, 'textchat', {
      insertMode: 'append',
      width: 400,
      height: 300
  });
});

  var form = document.querySelector('form');
  var msgTxt = document.querySelector('#msgTxt');

    form.addEventListener('submit', function(event) {
    event.preventDefault();

    session.signal({
      type: 'chat',
      data: msgTxt.value
    },
    function(error) {
      if (!error) {
        msgTxt.value = '';
      }
    });
  });


 var msgHistory = document.querySelector('#history');

   session.on('signal:chat', function(event) {
   var msg = document.createElement('p');
   msg.innerHTML = event.data;
   msg.className = event.from.connectionId === session.connection.connectionId ? 'mine' : 'theirs';
   msgHistory.appendChild(msg);
   msg.scrollIntoView();
  });
    });
})
}
$(document).ready(clicking);
$(document).on('page:load', clicking);
