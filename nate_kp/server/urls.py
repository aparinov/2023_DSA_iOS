from django.urls import include, path
from server import views
from .views import technical_requirementsCreate, technical_requirementsList, technical_requirementsDetail
from .views import projectCreate, projectList, projectDetail
from .views import requirements_stackCreate, requirements_stackList, requirements_stackDetail
from .views import applicationCreate, applicationList, applicationDetail
from .views import studentCreate, studentList, studentDetail
from .views import student_infoCreate, student_infoList, student_infoDetail
from .views import student_interestCreate, student_interestList, student_interestDetail
from .views import student_applicationsDetail
from .views import student_informationDetail
from .views import student_interests_listDetail
from .views import project_requirementsDetail
from rest_framework.authtoken.views import obtain_auth_token
from rest_framework.urlpatterns import format_suffix_patterns
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('requirements_create/', technical_requirementsCreate.as_view()),
    path('requirements/', technical_requirementsList.as_view()),
    path('requirements/<int:pk>/', technical_requirementsDetail.as_view()),
    path('project_create/', projectCreate.as_view()),
    path('projects/', projectList.as_view()),
    path('projects/<int:pk>/', projectDetail.as_view()),
    path('requirements_stack_create/', requirements_stackCreate.as_view()),
    path('requirements_stacks/', requirements_stackList.as_view()),
    path('requirements_stacks/<int:pk>/', requirements_stackDetail.as_view()),
    path('application_create/', applicationCreate.as_view()),
    path('applications/', applicationList.as_view()),
    path('applications/<int:pk>/', applicationDetail.as_view()),
  #  path('student_create/', studentCreate.as_view()),
    path('students/', studentList.as_view()),
    path('students/<int:pk>/', studentDetail.as_view()),
    path('student_info_create/', student_infoCreate.as_view()),
    path('student_infos/', student_infoList.as_view()),
    path('student_infos/<int:pk>/', student_infoDetail.as_view()),
    path('student_interest_create/', student_interestCreate.as_view()),
    path('student_interests/', student_interestList.as_view()),
    path('applications_by_student/<int:pk>/', student_applicationsDetail.as_view()),
    path('requirements_by_project/<int:pk>/', project_requirementsDetail.as_view()),
    path('information_by_student/<int:pk>/', student_informationDetail.as_view()),
    path('interests_by_student/<int:pk>/', student_interests_listDetail.as_view()),
    path('student_interests/<int:pk>/', student_interestDetail.as_view()),
    path('login/', obtain_auth_token, name='login'),
    path('api-auth/', include('rest_framework.urls')),
]

format_suffix_patterns(urlpatterns)
