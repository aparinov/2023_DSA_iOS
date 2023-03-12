from django.urls import path, include
from server import views
from rest_framework.authtoken.views import obtain_auth_token
from rest_framework.urlpatterns import format_suffix_patterns
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path('projects_create/', views.ProjectCreate.as_view()),
    path('projects/', views.ProjectList.as_view()),
    path('projects/<int:pk>/', views.ProjectView.as_view()),
    path('applications/', views.ApplicationsList.as_view()),
    path('applications/<int:pk>/', views.ApplicationsView.as_view()),
    path('requirements/', views.TechnicalRequirementsList.as_view()),
    path('requirements/<int:pk>/', views.TechnicalRequirementsView.as_view()),
    path('stack/', views.TechStackList.as_view()),
    path('stack/<int:pk>/', views.TechStackView.as_view()),
    path('info_list/', views.StudentInformationList.as_view()),
    path('info/', views.StudentInformationCreate.as_view()),
    path('info/<int:pk>/', views.StudentInformationView.as_view()),
    path('students_interests/', views.StudentsInterestsList.as_view()),
    path('students_interests/<int:pk>/', views.StudentsInterestsView.as_view()),
    path('interests/', views.InterestList.as_view()),
    path('interests/<int:pk>/', views.InterestView.as_view()),
    path('login/', obtain_auth_token, name='login'),
    path('api-auth/', include('rest_framework.urls')),
]

format_suffix_patterns(urlpatterns)
