from django.shortcuts import render
import joblib
import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from prophet import Prophet
from django.http import HttpResponse,JsonResponse
import json, requests, urllib

# Create your views here.

def model_pred(request):
    model = Prophet()
    model=joblib.load('..\model')
    future = model.make_future_dataframe(periods=7)
    future = future.tail(7)
    forecast = pd.DataFrame()
    forecast=model.predict(future)
    forecast = forecast.drop(forecast.columns.difference(['ds','yhat']), axis=1)
    forecast['ds']=forecast['ds'].astype(str)
    to_send = forecast.to_json()
    json_send = json.loads(to_send)
    simplified_json = {
        "ds": list(json_send['ds'].values()),
        "yhat": list(json_send['yhat'].values())
    }
    print(simplified_json)
    print(json_send)
    return JsonResponse(simplified_json)

def getLocation():
    geo = pd.read_csv('D:\\Ecothon\\GitProject\\ProjectBlueSky\\backend\\MODIS_C6_1_South_Asia_24h.csv')
    geo = geo.drop(geo[geo.latitude >= 30].index)
    geo = geo.drop(geo[geo.latitude <= 26].index)
    geo = geo.drop(geo[geo.longitude <= 80].index)
    geo = geo.drop(geo[geo.longitude >= 88].index)
    geo = geo.drop(geo[geo.confidence < 60].index)
    latitude=geo['latitude'].to_list()
    longitude=geo['longitude'].to_list()
    date=geo['acq_date'].to_list
    return latitude,longitude,date

def apiCreator():
    latitude,longitude,date=getLocation()
    print(latitude,longitude)
    api_key='1b10a7b511c240e488f843edfe344620'
    apis=[]
    for lat,lon in zip(latitude,longitude):
        api=f'https://api.geoapify.com/v1/geocode/reverse?lat={lat}&lon={lon}&apiKey={api_key}'
        apis.append(api)
    return apis

def jsonProcessor():
    apis = apiCreator()
    extracted_data = []
    for api in apis:
        response = requests.get(api)
        if response.status_code == 200:
            api_data=response.json()
            # api_data=json.loads(api_data)
            if 'features' in api_data:
                features = api_data['features']
                
                for feature in features:
                    properties = feature.get('properties', {})
                    if properties.get('country_code', 'N/A') == 'np':
                        extracted_data.append({
                            'country': properties.get('country', 'N/A'),
                            'country_code': properties.get('country_code', 'N/A'),
                            'state': properties.get('state', 'N/A'),
                            'county': properties.get('county', 'N/A'),
                            'city': properties.get('city', 'N/A'),
                        })
    print(extracted_data)
    return extracted_data

def fire_location(request):
    extracted_data = jsonProcessor()
    return JsonResponse({'data':extracted_data})

def updateFire():
    url='https://firms.modaps.eosdis.nasa.gov/data/active_fire/modis-c6.1/csv/MODIS_C6_1_SouthEast_Asia_24h.csv'
    urllib.request.urlretrieve(url, "D:\\Ecothon\\GitProject\\ProjectBlueSky\\backend\\MODIS_C6_1_South_Asia_24h.csv")
    print("Successful Download.")
    