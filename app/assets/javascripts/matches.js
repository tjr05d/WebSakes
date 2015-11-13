// var apiKey = '45406182'; // Replace with your API key. See https://dashboard.tokbox.com/projects
// var sessionID = session.session_id
//  // '1_MX40NTQwNjE4Mn5-MTQ0NzM4MDU1MjkzMX5FL2QwL291ZHljdjVUNG9MK0YrZklBMDJ-fg'; // Replace with your own session ID.
//                      // See https://dashboard.tokbox.com/projects
//  var token = token
//   // 'T1==cGFydG5lcl9pZD00NTQwNjE4MiZzaWc9ZTlhNTQwZjc0NTc5MzZlZWE4MWVhZGMyYWU4NTk2MTZlNzI3MTE5YTpyb2xlPXB1Ymxpc2hlciZzZXNzaW9uX2lkPTFfTVg0ME5UUXdOakU0TW41LU1UUTBOek00TURVMU1qa3pNWDVGTDJRd0wyOTFaSGxqZGpWVU5HOU1LMFlyWmtsQk1ESi1mZyZjcmVhdGVfdGltZT0xNDQ3MzgwNTk1Jm5vbmNlPTAuNTI2NjkxNjQ4NzUwOTQxNyZleHBpcmVfdGltZT0xNDQ3OTg1MzQ3JmNvbm5lY3Rpb25fZGF0YT0='; // Replace with a generated token that has been assigned the moderator role.
                 // See https://dashboard.tokbox.com/projects

clicking = function(api_key, session, token){
var apiKey = api_key;
var sessionID = session.session_id
var token = token 

 var session = OT.initSession(apiKey, sessionID);
 $('#startSession').on('click', function (){
  console.log("session started");
   session.connect(token, function(error) {
   if (error) {
     console.log(error.message);
   } else {
     // This example assumes that a DOM element with the ID 'publisherElement' exists
     $('#startChat').on('click', function() {
     var publisherProperties = {width: 400, height:300, name:"Bob's stream"};
     publisher = OT.initPublisher('', publisherProperties);
     session.publish(publisher);
     $('#endChat').on('click', function(){
       publisher.destroy();
     });
   });
   }
 });
 });

 session.on('streamCreated', function(event) {
   var subscriberProperties = {insertMode: 'append'};
   var subscriber = session.subscribe(event.stream,
     'subscriberContainer',
     subscriberProperties,
     function (error) {
       if (error) {
         console.log(error);
       } else {

         console.log('Subscriber added.');
       }
   });
 });
}


$(document).ready(clicking(api_key, session, token));
$(document).on('page:load', clicking(api_key, session, token));
