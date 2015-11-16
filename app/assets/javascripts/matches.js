clicking = function(){
  for (i = 0; i < '<%= #of matches %> '; i ++) {
  $('#AddIds').append('<span class = "startSession id ="ID'+ i +'" data-session = "<%= match.session_id %>" data-token= "<%= match.token%>">')
  }
 // var session = OT.initSession(apiKey, sessionID);

<<<<<<< HEAD
 // for (i =0; i < combined_matches.length ; i++) {


 $('.startSession').on('click', function (){
   console.log(this.getAttribute("data-session"))
   console.log(this.getAttribute("data-token"))
   var sessionID = this.getAttribute("data-session");
   var token = this.getAttribute("data-token");
   console.log("session started");
=======
 $('#startSession').on('click', function (){
   console.log(this.getAttribute("data-session"));
>>>>>>> feature/video_chat_targets
   var session = OT.initSession(apiKey, sessionID);
   session.connect(token, function(error) {
     if (error) {
       console.log(error.message);
     } else {
     // This example assumes that a DOM element with the ID 'publisherElement' exists
       $('#startChat').on('click', function() {
        //  $('#myModal').modal('show');
       var publisherProperties = {width: 300, height:200, name:"Tim's stream"};

       publisher = OT.initPublisher('publisherElement', publisherProperties);

       session.publish(publisher);

       $('#endChat').on('click', function(){
         publisher.destroy();
       });
      });
      }

      session.on('streamCreated', function(event) {
      session.subscribe(event.stream, 'subscriber', {
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
