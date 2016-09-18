import http.client, urllib.request, urllib.parse, urllib.error, base64
import json
from json import JSONEncoder
import csv
import time

headers = {
    # Request headers
    'Content-Type': 'application/json',
    'Ocp-Apim-Subscription-Key': '279e42df273d475d92337bd306daece3',
}

params = urllib.parse.urlencode({
})

exampleFile = open('SavedData.csv')
exampleReader = csv.reader(exampleFile)
#x = 1
blah = []
for row in exampleReader:
    jsonString = JSONEncoder().encode({
        "documents": [
         {
          "language": "en",
          "id": "trump",
          "text": str(row)
         }]
    })
    #x += 1

    try:
        conn = http.client.HTTPSConnection('westus.api.cognitive.microsoft.com')
        conn.request("POST", "/text/analytics/v2.0/sentiment?%s" % params, jsonString, headers)
        response = conn.getresponse()
        data = response.read().decode()
        what_you_want = json.loads(data)["documents"][0]
        what_you_want["time"] = str((round(time.time() * 1000)))
        blah.append(what_you_want)
        conn.close()
    except Exception as e:
        print("[Errno {0}] {1}".format(e.errno, e.strerror))

blah_blah = {"data": blah}
with open("Data.json", "w") as file:
    file.write((json.dumps(blah_blah, sort_keys=True, indent=2, separators=(',', ': '))))
