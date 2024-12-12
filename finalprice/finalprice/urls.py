from django.urls import path
from . import views

urlpatterns = [
    
    path('compare/', views.compare_products_api, name='compare_products_api'),
]
