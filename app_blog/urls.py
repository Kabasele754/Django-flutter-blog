from django.urls import path
from .views import BlogList, BlogDetail, BlogRetrieveUpdateDestroyView

urlpatterns = [
    path('blogs/', BlogList.as_view()),
    # path('blogs/<int:pk>/', BlogDetail.as_view()),
    path('blogs/<int:pk>/', BlogRetrieveUpdateDestroyView.as_view(), name='blog-retrieve-update-destroy'),

]

