var blackjack = (function() {
  function onCancel() {
      window.history.back();
  }

  function onBet(bet) {
      $.ajax({
          url: "/bet",
          type: "post",
          dataType: 'json',
          data: { bet: bet },
          success: startGame 
      });
  };

  function startGame() {
      $.ajax({
          url: "/initialize_game",
          type: "post",
          dataType: 'json',
          success: initializeGame 
      });
  }

  function playerHit() {
      $.ajax({
          url: "/player_hit",
          type: "post",
          datatype: "json",
          success: playerCallback
      });
  }

  function doubleDown() {
      disableControls();
      $.ajax({
          url: "/double_down",
          type: "post",
          success: doubleDownCallback
      });
  }

  function dealerTriesToWin() {
      $.ajax ({
        url: "/dealer_tries_to_win",
        type: "post",
        datatype: "json",
        success: dealerResults
      });
  }

  function onBust() {
      $.ajax({
          url: "/bust",
          type: "post"
      });
  }

  function onStand () {
      disableControls();
      document.getElementById("betVal").innerHTML = "You stand...";
      dealerTriesToWin();
  }

  function dealerResults(data) {
      var dealerBusted = data.bust;
      var delay = 0;
      data.images.forEach(function(image) {
          renderDealerCard(image, delay); 
          delay += 500;
      });
      setTimeout(function() {
          document.getElementById("dealerScore").innerHTML = "Dealer: " + data.score;
          if ( dealerBusted ) {
              document.getElementById("dealerScore").innerHTML = "BUST!";
          }
      }, delay);
      setTimeout(function() {renderResults(data.result)}, delay);
  }

  function renderDealerCard(image, delay) {
      setTimeout(function() {
          updateDealerCards(image, "Drawing...");
      }, delay);
  }

  function initializeGame(data) {
      document.getElementById("betView").style.display = "none";
      document.getElementById("gameView").style.display = "inline";
      disableControls();

      setTimeout(function () {
          updatePlayerCards(data.player_card_one, "Dealing...");
      }, 500);
      setTimeout(function () {
          updateDealerCards(data.dealer_card, "Dealer: " + data.dealer_score);
      }, 1000);
      setTimeout(function () {
          updatePlayerCards(data.player_card_two, "You: " + data.player_score);
      }, 1500);

      document.getElementById("betVal").innerHTML = "Bet: $" + data.bet;
      setTimeout(function () {enableControls()}, 2000);
  }

  function playerCallback(data) {
      document.getElementById("btnDouble").disabled = true;
      var playerBusted = data.bust;
      updatePlayerCards(data.image, "You: " + data.score);
      if ( playerBusted ) {
          onBust();
          disableControls();
          enableRefresh();
          document.getElementById("playerScore").innerHTML = "BUST!";
          document.getElementById("betVal").innerHTML = "Dealer wins...";
      }
  }

  function doubleDownCallback(data) {
      playerCallback(data);
      if ( !data.bust ) {
          setTimeout(onStand, 500);
      }
  }

  function renderResults(result) {
      document.getElementById("betVal").innerHTML = result;
      enableRefresh();
  }

  function updatePlayerCards(card_string, score) {
      var node = document.createElement("LI");
      var img = document.createElement("img");
      img.setAttribute('src', card_string);
      img.setAttribute('class', 'card');
      node.appendChild(img);
      document.getElementById("playerScore").innerHTML = score;
      document.getElementById("playerCards").appendChild(img);
  }

  function updateDealerCards(card_string, score) {
      var node = document.createElement("LI");
      var img = document.createElement("img");
      img.setAttribute('src', card_string);
      img.setAttribute('class', 'card');
      node.appendChild(img);
      document.getElementById("dealerScore").innerHTML = score;
      document.getElementById("dealerCards").appendChild(img);
  }

  function disableControls() {
      document.getElementById("btnHit").disabled = true;
      document.getElementById("btnStand").disabled = true;
      document.getElementById("btnDouble").disabled = true;
      document.getElementById("btnRefresh").disabled = true;
  }

  function enableControls() {
      document.getElementById("btnHit").disabled = false;
      document.getElementById("btnStand").disabled = false;
      document.getElementById("btnDouble").disabled = false;
  }

  function enableRefresh() {
      document.getElementById("btnHit").style.display = "none";
      document.getElementById("btnStand").style.display = "none";
      document.getElementById("btnDouble").style.display = "none";
      document.getElementById("btnRefresh").style.display = "block";
      document.getElementById("btnRefresh").disabled = false;
  }

  function reloadPage() {
      location.reload()
  }

  return {
    onBet: onBet,
    playerHit: playerHit,
    onStand: onStand,
    reloadPage: reloadPage,
    doubleDown: doubleDown
  };
}());
