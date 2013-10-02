var intervalId;
var done = "false";

function interval_check (jid) {
  console.log("interval_check was called")
  intervalId = setInterval(done_yet, 500,jid);
};

function done_yet (job_id){
  console.log("done_yet was called, and job id was "+job_id);
  $.post('/status/'+job_id, function(data){
    done = data;  //"true" or "false"
  });
};

function stop_checking() {
  clearInterval(intervalId);
};


$(document).ready(function() {
  $('#submit_tweet').submit(function(event){
    event.preventDefault();
    var tweet_content = $('#input_tweet').val();

    $.post('/submit_tweet', {tweet: tweet_content}, function(jid) {
      interval_check(jid);
    });

  });
});
