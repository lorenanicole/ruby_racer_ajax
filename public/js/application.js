
  $(document).ready(function() {
    var board_length = $('#player1_strip').children().length - 1;
    // console.log(board_length);
    playGame();
    $( "#results" ).on('click', function(e) {
      e.preventDefault();
      var url = "/results";
      var data = {data: $(this).attr('data-winner'),
                  time: $(this).attr('data-time')};
      $.post(url, data, function(response) {
        var statsUrl = $('#results').attr('data-game-id');
        window.location.replace("/stats/".concat(statsUrl));
      });
    });

    $( "#play-again" ).on('click', function(e) {
      e.preventDefault();
      var url = "/results";
      var data = {data: $(this).attr('data-winner'),
                  time: $(this).attr('data-time')};
      $.post(url, data, function(response) {
        var statsUrl = $('#play-again').attr('data-game-id');
        window.location.replace("/play");
      });
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
            $('#play-again').show();
            $('#results').attr('data-winner','2');
            $('#results').attr('data-time', endTime);
            $('#play-again').attr('data-winner','2');
            $('#play-again').attr('data-time', endTime);
          }
        } else if(event.which == 76) {
          p2_triggered ++;
          update_player_position('2',p2_triggered);
          if (p2_triggered == board_length) {
            endTime = $.now() - startTime;
            alert("Player 2 won!");
            $('#results').show();
            $('#play-again').show();
            $('#results').attr('data-winner','2');
            $('#results').attr('data-time', endTime);
            $('#play-again').attr('data-winner','2');
            $('#play-again').attr('data-time', endTime);
          }
        }
      });
    }
  });


  var p1_triggered = 0;
  var p2_triggered = 0;
  var update_player_position = function(player, position) {
    var current_player = '#player1_strip td:nth-child(position)'.replace(/1/,player).replace(/position/,position);
    position += 1;
    var player_position = '#player1_strip td:nth-child(position)'.replace(/1/,player).replace(/position/,position);
    $(current_player).removeClass();
    $(player_position).addClass('active');
  }

