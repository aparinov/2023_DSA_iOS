#!/usr/bin/env python
# coding: utf-8

# In[20]:
import pandas as pd
import requests
import sys
import random

def run(i):


  requests.get("http://84.201.135.211:8000/student_infos/5")

  SERVER_URL = 'http://84.201.135.211:8000/'
  STUDENT_INTERESTS_PATH = 'interests_by_student/'
  TAGS_PATH = 'requirements/'
  PROJECTS_PATH = 'projects/'
  PROJECT_TAGS_PATH = 'requirements_stacks/'
  OUTPUT_PATH = 'suggestions_create/'


  student_id = i
# student_id = 5

  student_interests = pd.read_json(f'{SERVER_URL}{STUDENT_INTERESTS_PATH}{student_id}')
  tags = pd.read_json(f'{SERVER_URL}{TAGS_PATH}')
  projects = pd.read_json(f'{SERVER_URL}{PROJECTS_PATH}')

# projects.head()

  pr_ids = projects['id'].unique().tolist()
  suggestions = random.sample(pr_ids, 5)

  for pr_id in suggestions:
#       res = '{' + f'"project_id": "{random.randint(1, len(projects))}",\n"student_id": "{student_id}"' + '}'
      res = {'project_id' : pr_id, 'student_id' : student_id}
      requests.post(f'{SERVER_URL}{OUTPUT_PATH}', data=res)
#     print(res)


# In[ ]:




