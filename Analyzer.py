import http.client, urllib.request, urllib.parse, urllib.error, base64
from json import JSONEncoder
import csv

headers = {
    # Request headers
    'Content-Type': 'application/json',
    'Ocp-Apim-Subscription-Key': '279e42df273d475d92337bd306daece3',
}

params = urllib.parse.urlencode({
})

exampleFile = open('SavedData.csv')
exampleReader = csv.reader(exampleFile)
x = 1
for row in exampleReader:
    jsonString = JSONEncoder().encode({
        "documents": [
         {
          "language": "en",
          "id": str(x),
          "text": str(row)
         }]
    })
    x += 1

    try:
     conn = http.client.HTTPSConnection('westus.api.cognitive.microsoft.com')
     conn.request("POST", "/text/analytics/v2.0/sentiment?%s" % params, jsonString, headers)
     response = conn.getresponse()
     data = response.read()
     print(data)
     conn.close()
    except Exception as e:
     print("[Errno {0}] {1}".format(e.errno, e.strerror))