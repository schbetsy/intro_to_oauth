var intervalId;
var done = "false";
var tweet_content;

function interval_check (jid) {
  intervalId = setInterval(done_yet, 300, jid);
};

function stop_checking() {
  console.log("it's done! we can stop checking!")
  clearInterval(intervalId);
  $('li:first-child').prepend('<li>' +tweet_content+ '</li>')
};
 
function done_yet (job_id){
  $.post('/status/'+job_id, function(data){
    done = data;  //"true" or "false"
  });
  console.log("done = "+done);
  if (done === "true") {
    stop_checking();
  }
};

$(document).ready(function() {
  $('#submit_tweet').submit(function(event){
    event.preventDefault();
    tweet_content = $('#input_tweet').val();

    $.post('/submit_tweet', {tweet: tweet_content}, function(jid) {
      interval_check(jid);
    });

  });
});
