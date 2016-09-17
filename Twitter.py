from tweepy import Stream
from tweepy import OAuthHandler
from tweepy.streaming import StreamListener
import time

# consumer key, consumer secret, access token, access secret.
ckey = "RmWJsWgJy6RVLgfW7DRVbs0ot"
csecret = "tUTiJtLh18pfZ1OWiV9C3SEakeqTP2QSGCTbsQU9BU7bd1R8l5"
atoken = "718889509-1VvMLO5YpFYWi9D09wvxRIBtSwKjQRRVC11O5G7M"
asecret = "iCQRxulCjTMjBKtcjq98vwhAtvhdECQ43ISgRrdWhHEKe"


class Listener(StreamListener):
    def on_data(self, data):
        try:
            print(data)
            tweet = data.split(',"text":"')[1].split('","source')[0]
            #savedTweet = str(time.time()) + "::" + tweet
            savedTweet = str(tweet)
            saveddata = open("SavedData.csv", 'a')
            saveddata.write(savedTweet)
            saveddata.write('\n')       # Add blank lines between saved data
            saveddata.close()
            return True
        except Exception:
            print("Failed on_data")
            time.sleep(5)

    def on_error(self, status):
        print(status)


auth = OAuthHandler(ckey, csecret)
auth.set_access_token(atoken, asecret)

twitterStream = Stream(auth, Listener())
twitterStream.filter(track=["trump", "clinton"])
