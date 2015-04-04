var dealerScore = 0;
var playerScore = 0;

function onBet() {
    var bet = document.getElementById("txtBet").value;
    $.ajax({
        url: "/bet",
        type: "post",
        dataType: 'json',
        data: { bet: bet },
        success: initializeGame
    });
};

function playerHit() {
    $.ajax({
        url: "/player_hit",
        type: "get",
        datatype: "json",
        success: playerCallback 
    });
}

function dealerHit() {
    $.ajax({
        url: "/dealer_hit",
        type: "get",
        datatype: "json",
        success: dealerCallback
    });
}

function onRoundOver() {
    $.ajax({
        url: "/decide_results",
        type: "get",
        success: renderResults
    });
}

function onBust() {
    $.ajax({
        url: "/bust",
        type: "get"
    });
}

function initializeGame(data) {
    document.getElementById("betView").style.display = "none";
    document.getElementById("gameView").style.display = "inline";
    disableControls();
    setTimeout(function () {playerHit()}, 500);
    setTimeout(function () {dealerHit()}, 1000);
    setTimeout(function () {playerHit()}, 1500);
    setTimeout(function () {enableControls()}, 2000);
    document.getElementById("foo").innerHTML = ("Bet: $" + data.bet + ".00")
}

function onStand () {
    disableControls();
    document.getElementById("foo").innerHTML = "You stand...";
    dealerTriesToWin();
}

function playerCallback(data) {
    playerScore = data.score;
    var playerBusted = data.bust;
    updatePlayerBox("playerCards", data.text, "playerScore", data.score);
    if ( playerBusted ) {
        onBust();
        disableControls();
        enableRefresh();
        document.getElementById("playerScore").innerHTML = "BUST!";
        document.getElementById("foo").innerHTML = "Dealer wins...";
    } 
}

function dealerCallback(data) {
    dealerScore = data.score;
    var dealerBusted = data.bust;
    updatePlayerBox("dealerCards", data.text, "dealerScore", data.score);
    if ( dealerBusted ) {
        document.getElementById("dealerScore").innerHTML = "BUST!";
    }
}

function dealerTriesToWin() {
    if (dealerScore < playerScore && dealerScore < 17) {
        dealerHit();
        setTimeout(function () {dealerTriesToWin()}, 500);
    }
    else {
        onRoundOver();
    }
}

function renderResults(data) {
    document.getElementById("foo").innerHTML = data.text
    document.getElementById("btnRefresh").disabled = false;
}

function updatePlayerBox(cardsListId, card_string, scoreId, score) {
    var node = document.createElement("LI");       
    var textnode = document.createTextNode(card_string);
    node.appendChild(textnode);
    document.getElementById(scoreId).innerHTML = "Score: " + score;
    document.getElementById(cardsListId).appendChild(node);
}

function disableControls() {
    document.getElementById("btnHit").disabled = true;
    document.getElementById("btnStand").disabled = true;
    document.getElementById("btnRefresh").disabled = true;
}

function enableControls() {
    document.getElementById("btnHit").disabled = false;
    document.getElementById("btnStand").disabled = false;
}

function enableRefresh() {
    document.getElementById("btnRefresh").disabled = false;
}

function reloadPage() {
  location.reload()
}
