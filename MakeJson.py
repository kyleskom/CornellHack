import csv
from json import JSONEncoder
import datetime
import json

exampleFile = open('Data.csv')
exampleReader = csv.reader(exampleFile)
for row in exampleReader:
    jsonString = JSONEncoder().encode({
        "tweet": [
         {
          "time": str(datetime.datetime.now()),
          "num": str(row[0])
         }]
    })
    jsonData = json.dumps(jsonString)
    #print(jsonData)
    savedTweet = str(jsonData)
    saveddata = open("Data.json", 'a')
    saveddata.write(savedTweet)
    saveddata.write('\n')
    saveddata.close()
