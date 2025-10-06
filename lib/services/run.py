import requests

url = "https://api.opensubtitles.com/api/v1/subtitles"

querystring = {"query":"Squid Game","languages":"en","season_number":"1","episode_number":"1"}

headers = {
    "User-Agent": "SubSearcher",
    "Api-Key": "yzH9BPmZp3d587bzGcyir2JF9SzVVPrJ"
}

response = requests.get(url, headers=headers, params=querystring)

print(response.json())