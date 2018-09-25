# -*- coding: utf-8 -*-
"""
Created on Mon Sep 24 15:56:57 2018

@author: Michael Silva
"""

import requests
import json
import time
import asyncio
import pandas as pd
 
test_runs = 100
 
# BLS API Parameters
BLS_API_key = 'ENTER YOUR API KEY HERE'
headers = {'Content-type': 'application/json'}
 
BLS_LAUS_state_area_codes = ['ST0100000000000', 'ST0200000000000', 'ST0400000000000', 'ST0500000000000', 'ST0600000000000', 'ST0800000000000', 'ST0900000000000', 'ST1000000000000', 'ST1100000000000', 'ST1200000000000', 'ST1300000000000', 'ST1500000000000', 'ST1600000000000', 'ST1700000000000', 'ST1800000000000', 'ST1900000000000', 'ST2000000000000', 'ST2100000000000', 'ST2200000000000', 'ST2300000000000', 'ST2400000000000', 'ST2500000000000', 'ST2600000000000', 'ST2700000000000', 'ST2800000000000', 'ST2900000000000', 'ST3000000000000', 'ST3100000000000', 'ST3200000000000', 'ST3300000000000', 'ST3400000000000', 'ST3500000000000', 'ST3600000000000', 'ST3700000000000', 'ST3800000000000', 'ST3900000000000', 'ST4000000000000', 'ST4100000000000', 'ST4200000000000', 'ST4400000000000', 'ST4500000000000', 'ST4600000000000', 'ST4700000000000', 'ST4800000000000', 'ST4900000000000', 'ST5000000000000', 'ST5100000000000', 'ST5300000000000', 'ST5400000000000', 'ST5500000000000', 'ST5600000000000']
measures = ['03', '04', '05']
 
# Translate the area codes to series ids
seriesids = list()
for BLS_LAUS_state_area_code in BLS_LAUS_state_area_codes:
    for measure in measures:
        seriesids.append('LAS' + BLS_LAUS_state_area_code + measure)
 
number_of_requests = len(seriesids)
 
 
def fetch(seriesid):
    data = json.dumps({'seriesid': [seriesid], 'registrationkey': BLS_API_key})
    response = requests.post('https://api.bls.gov/publicAPI/v2/timeseries/data/', data=data, headers=headers)
    return response.json()
 
def async_fetch(seriesid):
    data = json.dumps({'seriesid': [seriesid], 'registrationkey': BLS_API_key})
    headers = {'Content-type': 'application/json'}
    response = requests.post('https://api.bls.gov/publicAPI/v2/timeseries/data/', data=data, headers=headers)
    return (seriesid, response.json())
 
async def fetch_all(seriesids):
    loop = asyncio.get_event_loop()
    futures = [
        loop.run_in_executor(
            None, 
            async_fetch, 
            seriesid
        )
        for seriesid in seriesids
    ]
    for d in await asyncio.gather(*futures):
        temp[d[0]] = d[1]
         
temp = dict()
results = dict()
 
for i in range(test_runs):
    test_run = i + 1
 
    # Test A - Synchronous Requests
    start_time = time.time()
     
    for seriesid in seriesids:
        temp[seriesid] = fetch(seriesid)
     
    synchronous_time = time.time() - start_time
     
    print("Test " + str(test_run) + "-A " + str(number_of_requests) + " Sychronous Requests: %s seconds" % (synchronous_time))
     
    # Test B - Asynchronous Requests
    start_time = time.time()
     
    loop = asyncio.get_event_loop()
    loop.run_until_complete(fetch_all(seriesids))
     
    asynchronous_time = time.time() - start_time
     
    print("Test " + str(test_run) + "-B " + str(number_of_requests) + " Asychronous Requests: %s seconds" % (asynchronous_time))
    results[test_run] = {'Synchronous': synchronous_time, 'Asynchronous': asynchronous_time}
 
loop.close()
df = pd.DataFrame.from_dict(results, orient='index')
writer = pd.ExcelWriter('BLS Test.xlsx')
df.to_excel(writer,'Results')
writer.save()
