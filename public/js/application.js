
$(document).ready(function() {
  $('#submit_tweet').submit(function(event){
    event.preventDefault();
    var tweet_content = $('#input_tweet').val();
    $.post('/submit_tweet', {tweet: tweet_content}, function(response) {
      console.log(response); 

      var done_yet = $.get('/status/'+ response, function(data){
          console.log("get request");
          // $.done(function(data){console.log(data)});
        })
  

      // var done_yet = $.get('/status/'+ response); 

      setTimeout(done_yet,30)
      console.log(done_yet)
    })

  });
});
