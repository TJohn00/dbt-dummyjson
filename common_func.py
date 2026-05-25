import requests as r
def fetch_function(url,data_key):
    limit=100
    skip=0
    all_data = []
    req = r.get(f"{url}?limit={limit}&skip={skip}").json()
    total = req["total"]
    all_data += req[data_key]
    skip = limit

    while skip<total:
        req = r.get(f"{url}?limit={limit}&skip={skip}").json()
        all_data +=req[data_key]
        skip+=limit
    
    return all_data