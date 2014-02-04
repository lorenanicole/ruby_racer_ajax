(function(){
  $(document).ready(function() {
    var board_length = $('#player1_strip').children().length - 1;
    // console.log(board_length);
    playGame();
    $( "#results" ).on('click', function(e) {
      e.preventDefault();
      var url = "/results";
      var data = {data: $(this).attr('data-winner'),
                  time: $(this).attr('data-time')}
      console.log(data)
      $.post(url, data, function(response) {
        console.log(response)
        $('body').html(response);
      })
    });
    function playGame() {
      var startTime = $.now();
      $(document).on('keyup', function(event) {
        if(event.which == 65) {
          p1_triggered ++;
          update_player_position('1',p1_triggered);
          if (p1_triggered == board_length) {
            endTime = $.now() - startTime;
            console.log(time);
            alert("Player 1 won!");
            $('#results').show();
            $('#results').attr('data-winner','1');
            $('#results').attr('data-time', endTime);
          }
        } else if(event.which == 76) {
          p2_triggered ++;
          update_player_position('2',p2_triggered);
          if (p2_triggered == board_length) {
            endTime = $.now() - startTime;
            alert("Player 2 won!");
            $('#results').show();
            $('#results').attr('data-winner','2');
            $('#results').attr('data-time', endTime);
          }
        }
        // Detect which key was pressed and call the appropriate function
        // Google "jquery keyup what key was pressed" if you don't know how
      });
    }
  });


  // position == where you are at before key stroke


  var p1_triggered = 0;
  var p2_triggered = 0;
  var update_player_position = function(player, position) {
    var current_player = '#player1_strip td:nth-child(position)'.replace(/1/,player).replace(/position/,position);
    // current_player = current_player.replace(/position/,position);
    // console.log(current_player);
    position += 1;
    var player_position = '#player1_strip td:nth-child(position)'.replace(/1/,player).replace(/position/,position);
    // console.log(player_position);
    $(current_player).removeClass();
    $(player_position).addClass('active');
  }
}());
  // var reset = function() {
  //   $('#results').show()
  // }

  // $( "#results" ).click(function() {
  //   location.reload();
  // });

  // update_player_position('1',2)
