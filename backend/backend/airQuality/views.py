from django.shortcuts import render
import joblib
import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from prophet import Prophet
from django.http import HttpResponse

# Create your views here.

def model_pred(request):
    model = Prophet()
    model=joblib.load('..\model')
    return HttpResponse('Hello')
