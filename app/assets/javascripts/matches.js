// var apiKey = @api_key
// // '45406182';
//
// var sessionID = @session.session_id
//  // '1_MX40NTQwNjE4Mn5-MTQ0NzM4MDU1MjkzMX5FL2QwL291ZHljdjVUNG9MK0YrZklBMDJ-fg';
//
// var token = @token
//  // 'T1==cGFydG5lcl9pZD00NTQwNjE4MiZzaWc9ZTlhNTQwZjc0NTc5MzZlZWE4MWVhZGMyYWU4NTk2MTZlNzI3MTE5YTpyb2xlPXB1Ymxpc2hlciZzZXNzaW9uX2lkPTFfTVg0ME5UUXdOakU0TW41LU1UUTBOek00TURVMU1qa3pNWDVGTDJRd0wyOTFaSGxqZGpWVU5HOU1LMFlyWmtsQk1ESi1mZyZjcmVhdGVfdGltZT0xNDQ3MzgwNTk1Jm5vbmNlPTAuNTI2NjkxNjQ4NzUwOTQxNyZleHBpcmVfdGltZT0xNDQ3OTg1MzQ3JmNvbm5lY3Rpb25fZGF0YT0=';

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
       var publisherProperties = {width: 400, height:300, name:"Tim's stream"};

       publisher = OT.initPublisher('publisherElement', publisherProperties);

       session.publish(publisher);

       $('#endChat').on('click', function(){
         publisher.destroy();
       });
      });
      }
 });

  $('#joinSession').on('click', function (){
    console.log("joining a session");
    var session = OT.initSession(apiKey, join_sessionID);
    session.connect(token, function(error) {
      if (error) {
        console.log(error.message);
      } else {
      // This example assumes that a DOM element with the ID 'publisherElement' exists
        var publisherProperties = {width: 400, height:300, name:"Tim's stream"};

        publisher = OT.initPublisher('publisherElement', publisherProperties);

        session.publish(publisher);

        $('#endChat').on('click', function(){
          publisher.destroy();
        });
       });
       }
  })
 });
}


$(document).ready(clicking);
$(document).on('page:load', clicking);
