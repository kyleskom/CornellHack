var Twitter = require('twitter');
var firebase = require("firebase");

var client = new Twitter({
  consumer_key: 'JDL6g0mbJoNZyIYkHE1t2X6kJ',
  consumer_secret: 'AMDpWhg1vjMbpFoNDp930SBrB7xgeMIHDKMOGDUDwS1tPxZYbb',
  access_token_key: '3087606059-Wg6jIZL9aES3WwlbbGGyickUHmUlcxLeftw0py5',
  access_token_secret: 	'JkeZvG1hVB98yTPJiPfv2VT1OTE2jTt9TpsziZptpZkZh'
});


var config = {
  apiKey: "AIzaSyC6uDkxL7xuGgoInJx6rdZbUdDyNd2nXUo",
  authDomain: "cornellhack-85315.firebaseapp.com",
  databaseURL: "https://cornellhack-85315.firebaseio.com",
  storageBucket: "cornellhack-85315.appspot.com",
  messagingSenderId: "860830358842"
};
firebase.initializeApp(config);

function guid() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
      .toString(16)
      .substring(1);
  }
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
    s4() + '-' + s4() + s4() + s4();
}

function sleep(delay) {
    var start = new Date().getTime();
    while (new Date().getTime() < start + delay);
}

var request = require('request');
var url = 'https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'

// Lets configure and request

// { documents: [ { score: 0.7228703, id: '1' } ], errors: [] }

// parse json

function getEmotionValueAndPushToFirebase(text, candidate) {

    var idiot = candidate;

    request({
        url: url, //URL to hit
        method: 'POST',
        json:{"documents":[{"language": "en","id":"1","text": text}]},//Specify the method
        headers: { //We can define headers too
            'Content-Type': 'application/json',
            'Ocp-Apim-Subscription-Key': '279e42df273d475d92337bd306daece3'
        }
    }, function(error, response, body){
        if(error) {
            console.log(error);
        } else {

            var obj = body["documents"][0];
            var score = obj.score;

            console.log(score);
            writeDataToFirebase(idiot, score);

        }
    });
}

var db = firebase.database();

function writeDataToFirebase(candidate, score) {
    var id = guid();

    firebase.database().ref('tweets/'+candidate+'/'+ id).set({
        sentimentScore: score
    });
}

// STREAM FOR TRUMP
client.stream('statuses/filter', {track: 'javascript'}, function(stream) {
  stream.on('data', function(event) {
      getEmotionValueAndPushToFirebase(event.text, 'trump');
});
  stream.on('error', function(error) {
    throw error;
  });
});

// STREAM FOR HILARY
client.stream('statuses/filter', {track: 'node'}, function(stream) {
  stream.on('data', function(event) {
    getEmotionValueAndPushToFirebase(event.text, 'clinton');
});
  stream.on('error', function(error) {
    throw error;
  });
});
