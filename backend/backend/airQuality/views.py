from django.shortcuts import render
import joblib
import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from prophet import Prophet
from django.http import HttpResponse,JsonResponse
import json

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
    return JsonResponse(json_send)
