# 2023_DSA_iOS

## Руководство по эксплуатации системы
### Общая информация
![image](https://user-images.githubusercontent.com/60274420/227986991-10abf151-e219-400f-8a83-8750fcd720bb.png)

Система состоит из серверной части (сервер, база данных и рекомендательная модель), веб-интерфейса и мобильного приложения. С точки зрения кода, существуют файлы серверной части и веб-интерфейса вместе и файлы мобильного приложения, которые запускаются на разных устройствах.

### Руководство по поддержке мобильного приложения
Мобильное приложение написано c использованием языка [Swift](https://www.apple.com/ru/swift/) (версии 5) и среды разработки [XCode](https://developer.apple.com/xcode/) (14.2). Для изменения кода приложения вам потребуется ноутбук Macbook, данные инструменты, а также инструменты [UIKit](https://getuikit.com/) и [SwiftUI](https://developer.apple.com/xcode/swiftui/) для написания пользовательского интерфейса, [Foundation](https://developer.apple.com/documentation/foundation) для работы с основными сущностями языка Swift, [Combine](https://developer.apple.com/documentation/combine) для реактивного программирования, [SwiftPM](https://www.swift.org/package-manager/) и библиотека [Alamofire](https://github.com/Alamofire/Alamofire)  для работы с сетью (подключается с помощью SwiftPM). Убедитесь, что у вас установлены все эти инструменты, прежде чем начать работу над приложением.

Исходный код приложения доступен в ветке mobileAppMVP данного репозитория.
#### Структура мобильного приложения
Приложение организовано в парадигме [ModelViewViewModel+Coordinator](https://medium.com/nerd-for-tech/mvvm-coordinators-ios-architecture-tutorial-fb27eaa36470). 

В основной директории находятся две главные директории: Scenes, отвечающие за реализацию архитектурного паттерна, в сцене каждого экрана находятся следующие разделы: Model(Модели данных), View(Дополнительно реализованные View), ViewModel(ViewModel для работы с сервисами и обновления данных на UI), ViewController(То что в архитектуре является View, основная сущность экрана) и Services, в котором находятся сервис для работы с сетью и вспомогательные модели данных. 

Для изменения взаимодействия с сервером (например, добавления нового запроса) обратитесь к файлу MobieApp/CWChooser/Services/NetworkService.swift.

Для изменения поведения или внешнего вида найдите директорию внутри директории Scenes, соответствующую вашему целевому экрану:
* AuthorizationScene - экран авторизации пользователя.
* CreateProjectScene - экран создания проекта.
* MainScene - экран списка проектов.
* ProfileScene - экран личного кабинета пользователя.
* ProjectDetailScene - экран отображения подробной информации о проекте.
* QuizScene - экран опроса интересов пользователя.

### Руководство по поддержке сервера
Для разработки сервера был использован [Django rest framework](https://www.django-rest-framework.org/) с использованием библиотеки [django allauth]( https://django-allauth.readthedocs.io/en/latest/) для осуществления аутентификации. Разработка осуществлялась на языке [Python](https://www.python.org/) и html.

Базы данных написаны на языке SQL на базе [PostgreSQL](https://www.postgresql.org/). Для разработки использовалась среда [DataGrip](https://www.jetbrains.com/ru-ru/datagrip/). Убедитесь, что у вас установлены все необходимые инструменты, в частности пакеты Python и Django rest framework.

Исходный код сервера можно найти в ветке main данного репозитория.
#### Структура сервера
В ветке main данного репозитория находится директория env с виртуальной средой, нужной для работы Python с проектом, и директория nate_kp, соответствующая всему проекту Django rest framework.
##### Директория nate_kp - старшая
Внутри этой директории nate_kp располагаются объекты проекта: 
* директория nate_kp с файлами, относящимися ко всему проекту целиком, в частности с настройками, 
* директория provider, где расположено приложение для расширения библиотечного решения авторизации django allauth [28], позволяющее подключить провайдера авторизации кроме заданных (например, ЕЛК ВШЭ),
* директория server - относящаяся к приложению, собственно, сервера, используемого в этом проекте и взаимодействующего с базой данных, 
* директория templates, содержащая документы верстки html страниц, 
* файл manage.py, с помощью которого запускаются приложения проекта.

###### Директория nate_kp - младшая
Здесь находятся два иногда нужных файла:
* urls.py - файл с ссылками верхнего уровня. Сюда включаются промежуточные адреса и, в частности, адрес accounts для включения аутентификации django-allauth.
* settings.py - файл настроек проекта. Здесь подключаются приложения и пакеты (в список INSTALLED_APPS, например, приложение provider, которое будет описано ниже, или allauth - библиотека авторизации), подключается база данных ![image](https://user-images.githubusercontent.com/60274420/228050092-daea0295-bf32-4f92-aa2e-3722968702e5.png)


###### Директория provider
Это директория для кастомного провайдера аутентификации пользователя, расширяющего сущность провайдера из библиотеки django-allauth. В целом не нуждается в редактировании и готов к использованию, но можно изменить в соответствии с потребностями от провайдера. Например, можно определить, какие поля будут захватываться при аутентификации из данных стороннего сервиса в файле provider.py. 

###### Директория server
В директории server находятся наиболее интересующие для разработки файлы:
* model.py - это файл рекомендательной системы. Она импортируется в файл views.py и вызывается оттуда в классе student_suggestionsDetail, который отвечает за предоставление информации о рекомендованных студенту проектах. Внутри файл model.py должен содержать функцию run, внутри которой должна происходить вся работа - именно эта функция и запускается снаружи. Если захотите изменить или заменить файл, соблюдайте его расположение и эту структуру.
* models.py - это модели данных. Здесь описываются сущности системы, и они должны соответствовать схемам таблиц в базе данных.
* permissions.py - файл, в котором описаны ограничения доступа к информации для пользователей, далее указываемые в представлениях данных. Можно добавить свои настройки ограничений с помощью классов в этом файле.
* serializers.py - это файл классов-сериализаторов для определения json представлений всех объектов из моделей.
* urls.py - это файл с endpoint ссылками - адресами, доступными для пользователей веб-интерфейса и запросами, доступными для совершения с клиентских частей.
* views.py - это представления данных, на которые пользователей переводят ссылки. Например, если по ссылке пользователь должен увидеть список объектов - класс, соответствующий этому списку нужно задать в этом файле и указать при создании ссылки в файле urls.py.

###### Директория templates
Здесь находится файл home.html - разметка домашней страницы. Чтобы поменять внешний вид страницы по домашнему адресу поменяйте код внутри этого файла.

#### Основные команды и действия
Наиболее нужные из команд в связи со сценариями перечислены ниже. Они написаны для терминала системы Linux. Вместо python3 используйте версию python, установленную на вашем устройстве.
##### Запустить сервер
из директории верхнего уровня (в которой расположена директория env) введите команду: 

    $ source env/bin/activate

спуститесь в директорию nate_kp (где расположен файл manage.py) и введите команду:

    $ python3 manage.py runserver 0.0.0.0:8000

Эта команда соответствует запуску сервера на порте 8000.
##### Синхронизировать измененную модель данных с базой данных Postgres
из директории nate_kp (где расположен файл manage.py) введите команду:

    $ python3 manage.py makemigrations

эта команда покажет вам существующие изменения. Если есть изменения и вы хотите их применить, введите команду:

    $ python3 manage.py migrate
##### Добавить новую сущность в базу данных с помощью серверного представления
Сущности располагаются в файле models.py. Добавьте туда требуемый класс, укажите его поля, метаинформацию (название таблицы. Она не обязательно должна существовать, если ее нет - она сгенерируется автоматически). 

Далее определите сериализатор нового типа объектов в файле serializers.py. Здесь определяется json формат, в который будет преобразовываться объект. Вы можете добавить туда не все поля модели и, например, скрыть какую-то информацию. Обязательно в сериализаторе укажите используемую модель данных, которую вы создали ранее (и не забудьте экспортировать ее в файл сериализаторов с помощью импорта наверху).

Далее определите представления нового типа с помощью создания класса в файле views.py по аналогии с существующими - какие действия пользователь может делать с этим объектом? Джанго предоставляет ряд стандартных представлений, например: generics.ListAPIView - это список объектов данного типа, предоставляет список, generics.CreateAPIView - это создание одного нового объекта такого типа, имеет только метод POST, generics.RetrieveUpdateDestroyAPIView - доступ к существующему объекту для просмотра (GET), удаления (DELETE), редактирования (PUT), предоставляет единичный элемент, и т.д. Укажите используемый сериализатор, созданный ранее (и не забудьте его импортировать в текущий файл) и возможные фильтры для запросов. 

Теперь добавьте в файл urls.py ссылки для доступа к новому представлению (не забудьте его импортировать). Для этого добавьте ссылку в список ссылок по аналогии с другими и укажите требуемое представление.
Наконец, введите команды для синхронизации измененной модели с базой данных и запустите сервер - изменения отразятся там.

Например, для сущности проекта

Модель в models.py выглядит так:

    class project(models.Model):
        title = models.CharField("title", max_length=255)
        description = models.CharField("description", max_length=5000)
        project_type = models.CharField("project_type", max_length=20)
        supervisor = models.CharField("supervisor", max_length=100, default = "")
        number_of_students = models.IntegerField("number_of_students")
        submission_deadline = models.CharField("submission_deadline", max_length = 20)
        application_deadline = models.CharField("application_deadline", max_length = 20)
        application_form = models.CharField("application_form", max_length=255)
        status = models.CharField("status", max_length=20)

        class Meta:
            managed = False
            db_table='project'
        
Сериализатор в serializers.py выглядит так:

    class projectSerializer(serializers.ModelSerializer):

        class Meta:
            model = project
            fields = ['id', 'title', 'description', 'project_type', 'supervisor', 'number_of_students', 'submission_deadline', 'application_deadline', 'application_form', 'status']
        
 Представления во views.py выглядят так:
 
 Для создания проекта
 
     class projectCreate(generics.CreateAPIView):
        # API endpoint that allows creation of a new customer
        queryset = project.objects.all(),
        serializer_class = projectSerializer

Для списка проектов

    class projectList(generics.ListAPIView):
        # API endpoint that allows customer to be viewed.
        queryset = project.objects.all()
        serializer_class = projectSerializer

Для просмотра, редактирования и удаления конкретного проекта

    class projectDetail(generics.RetrieveUpdateDestroyAPIView):
        # API endpoint that returns a single customer by pk.
        queryset = project.objects.all()
        serializer_class = projectSerializer

Ссылки в urls.py выглядят так:

Для создания нового проекта

    path('project_create/', projectCreate.as_view()),
 
Для просмотра списка проектов

    path('projects/', projectList.as_view()),

Для просмотра, редактирования, удаления конкретного проекта по ключу его идентификатора

    path('projects/<int:pk>/', projectDetail.as_view()),

#### Структура базы данных
База данных состоит из некоторого количества таблиц, часть из которых генерируется автоматически. Для нас представляет  интерес та часть, которая написана вручную и отражает объекты в модели системы. Также в системе присутствуют срезы данных, представляющие собой агрегированные данные из нескольких таблиц. 
Все они перечислены далее, и их схема представлена на рисунках.
* Таблица student - это таблица студентов, содержит только идентификаторы и email, используемый пользователем для авторизации. Связана с автоматически генерируемой таблицей пользователей user по идентификатору. Триггер на создание студента в таблице прикреплен к авторизации пользователя в первый раз.
* Таблица project - это таблица проектов, содержащее всю информацию о проектах кроме тэгов(технических требований) - кратких описаний технологий, областей знаний и навыков, требуемых от студентов.
* Таблица technical_requirements - это таблица, содержащая идентификаторы тэгов и их названия. Пользователь в приложении не имеет возможности создавать эти тэги, они настраиваются администратором через веб-интерфейс (или вносятся напрямую в базу данных).
* Таблица student_interests - это таблица “многие ко многим” для соответствия студентов и их интересов. Одна запись в такой таблице - это информация о том, что студент с данным идентификатором выбрал тэг с данным идентификатором как свой интерес.
* Срез student_interests_list - это срез, позволяющий агрегировать все интересы студента с их названиями. При получении записи из него запрашивающий увидит идентификатор данного студента, идентификаторы и текстовые названия всех его интересов.
* Таблица student_info - это таблица с подробной информацией о студенте. Она содержит дополнительную информацию, такую как имя, факультет и т.д., а также идентификатор студента из таблицы student, которому эта информация соответствует. Разделение базовой информации о пользователе и детализированных данных на разные таблицы продиктовано тем, что в логике приложения пользователь задает свои данные несколько позже, чем создается объект студента, а также потому что основная информация о пользователе нужна чаще. С помощью разделения можно удобнее создавать и изменять эти данные, а также не использовать их без надобности.
* Срез student_information - это агрегированный срез, представляющий собой полную информацию о студенте - и общую, и базовую, объединенные в один json объект.
* Таблица application - это таблица “многие ко многим” заявок студентов на проекты. Одна запись соответствует информации о том, что студент с данным идентификатором подал заявку на проект с данным идентификатором. Кроме того, она содержит поле статуса заявки - после подачи оно равняется “заявка подана”, далее же, например при отмене заявки, меняется на “заявка отменена”. В случае, если руководитель проекта из веб-интерфейса решит одобрить заявку - статус может быть изменен на “заявка одобрена”. Статус введен для того, чтобы расширить возможную информацию, при этом не добавляя другие сущности и не удаляя записи из этой таблицы при отмене заявок.
* Срез student_applications - это агрегированный срез, позволяющий увидеть все заявки студента с их идентификаторами, статусами, а также информацией о проектах, на которые они были поданы, с полными описаниями.
* Таблица requirements_stack - это таблица “многие ко многим” для соответствия тэгов и проектов. Одна запись из такой таблицы соответствует информации о том, что проекту с данным идентификатором добавлен тэг с данным идентификатором.
* Срез project_requirements - агрегированный срез, позволяющий для данного проекта увидеть все тэги, причем не только их идентификаторы, но и названия.
* Таблица suggestions - это таблица “многие ко многим” соответствия рекомендаций проектов студентам. Одна запись соответствует информации о том, что студенту с данным идентификатором предложен проект с данным идентификатором.
* Срез student_suggestions - это агрегация всех предложенных студенту с данным идентификатором проектов, с полным их описанием.

![image](https://user-images.githubusercontent.com/60274420/228051497-3330bfce-93b4-4d92-b0a7-af7e07259093.png)
![image](https://user-images.githubusercontent.com/60274420/228051546-2d04f14a-fd92-45cd-85cb-9f0f88665c05.png)
![image](https://user-images.githubusercontent.com/60274420/228051582-f7a1af41-dfc7-4386-a596-727941574a11.png)
![image](https://user-images.githubusercontent.com/60274420/228051611-b4aad1f2-98ac-429f-bab6-66c41dd08463.png)
![image](https://user-images.githubusercontent.com/60274420/228051635-e8b669f3-5cc5-432a-a04b-790e7d4d771b.png)
![image](https://user-images.githubusercontent.com/60274420/228051662-4e48b4df-b386-4a24-8855-1f9d097530c8.png)

#### Запросы
##### Авторизации
* http://84.201.135.211:8000/ - домашняя страница, вход на сайт и страницу для начала авторизации, POST запрос без параметров
* admin/ - вход в аккаунт администратора, 

POST запрос формата 

    {
        "username":"username", 
        "password":"password"
    }

* accounts/login/ - авторизация через доступные сторонние сервисы, 

POST запрос формата 

    {
        "username":"username",
        "password":"password"
    }

* accounts/yandex/login/?process=login/ -  для переадресации на авторизацию через Yandex&HSE, POST запрос без параметров
* hse-auth/ - для переадресации на авторизацию через аккаунт ЕЛК, пока не работает, POST запрос без параметров
* get_username - GET запрос для получения данных об авторизованном в сессии пользователе, 

выдает json объект формата 

    {
        "id": 18,
        "username": "ndzubareva@edu.hse.ru"
    }

##### Работа со студентами:
* students/ - просмотр всех студентов, 

GET запрос, выдает json объект формата 

\[

    {
        "id": 18,
        "email": "ndzubareva@edu.hse.ru"
    },
    {
        "id": 19,
        "email": "vapovolotskiy@edu.hse.ru"
    }
]

* students/int:pk/ - просмотр, редактирование, удаление конкретного студента

GET запрос для получения информации, возвращающий объект 

    {
        "id": 19,
        "email": "vapovolotskiy@edu.hse.ru"
    }

PUT запрос для редактирования в формате

    {
        "email": "vapovolotskiy@edu.hse.ru"
    }

DELETE запрос формата

    {
        "id": 19,
        "email": "vapovolotskiy@edu.hse.ru"
    }

* student_info_create/ - создание подробной информации о студенте, 

POST запрос формата 

    {
       "student_id": 19,
       "name": "Поволоцкий Виктор",
       "group": "ФКН",
       "faculty": "БПИ196",
       "year": 4,
       "phone_number": "+79283390387"
    }

* student_infos/ - просмотр всей инфо по студентам, 

GET запрос, возврат формата 

\[

    {
       "id": 107,
       "student_id": 19,
       "name": "Поволоцкий Виктор",
       "group": "ФКН",
       "faculty": "БПИ196",
       "year": 4,
       "phone_number": "+79283390387"
    },
    {
       "id": 108,
       "student_id": 20,
       "name": "Мостачев Андрей",
       "group": "ФКН",
       "faculty": "БПИ196",
       "year": 4,
       "phone_number": "+715156279"
    }
]

* student_infos/int:pk/ - просмотр, редактирование, удаление инфо конкретного студента

GET запрос для получения информации, возвращающий объект 

    {
       "id": 108,
       "student_id": 20,
       "name": "Мостачев Андрей",
       "group": "ФКН",
       "faculty": "БПИ196",
       "year": 4,
       "phone_number": "+715156279"
    }

PUT запрос для редактирования в формате

    {
       "student_id": 20,
       "name": "Мостачев Андрей",
       "group": "ФКН",
       "faculty": "БПИ196",
       "year": 4,
       "phone_number": "+715156279"
    }

DELETE запрос формата

    {
       "id": 108,
       "student_id": 20,
       "name": "Мостачев Андрей",
       "group": "ФКН",
       "faculty": "БПИ196",
       "year": 4,
       "phone_number": "+715156279"
    }

##### Работа с тегами
* requirements_create/ - создание тега, 

POST запрос формата 
    
    {
        "name" : "Swift"
    }

* requirements/ - просмотр всех тегов, 
GET запрос формата 

\[

    {
        "id": 5,
        "name": "Мобильная разработка"
    },
    {
        "id": 6,
        "name": "Веб-разработка"
    }
]

* requirements/int:pk/ - просмотр, редактирование, удаление конкретного тега

GET запрос для получения информации, возвращающий объект 

    {
        "id": 5,
        "name": "Мобильная разработка"
    }

PUT запрос для редактирования в формате

    {
        "name" : "Swift"
    }

DELETE запрос формата

    {
        "id": 5,
        "name": "Мобильная разработка"
    }

##### Работа с проектами:
* project_create/ -	создание проекта, 

POST запрос формата

    {
        "title": "Приложение для интраоперационного мультилингвального картирования речи",
        "description": "Приложение для автоматизации процесса проведения теста на называние - процедуры, проводимой во время операций на мозге с целью предотвращения потери речи. Требуется разработать кроссплатформенное мобильное приложение (в первой версии для платформы Android), которое бы позволяло добавлять пациентов для тестирования, проводить тестирование (с показом изображений, записью ответов тестируемого), проверять ответы.",
        "project_type": "Проектный",
        "supervisor": "Зонтов Юрий Владимирович",
        "number_of_students": 1,
        "submission_deadline": "2023-08-01",
        "application_deadline": "2022-10-01",
        "application_form": "https://www.hse.ru/neuroling/",
        "status": "набор завершен"
    }

* projects/ - просмотр всех проектов, 
GET запрос формата 

\[

    {
        "id": 4,
        "title": "Приложение для интраоперационного мультилингвального картирования речи",
        "description": "Приложение для автоматизации процесса проведения теста на называние - процедуры, проводимой во время операций на мозге с целью предотвращения потери речи. Требуется разработать кроссплатформенное мобильное приложение (в первой версии для платформы Android), которое бы позволяло добавлять пациентов для тестирования, проводить тестирование (с показом изображений, записью ответов тестируемого), проверять ответы.",
        "project_type": "Проектный",
        "supervisor": "Зонтов Юрий Владимирович",
        "number_of_students": 1,
        "submission_deadline": "2023-08-01",
        "application_deadline": "2022-10-01",
        "application_form": "https://www.hse.ru/neuroling/",
        "status": "набор завершен"
    },
    {
        "id": 5,
        "title": "Клиент-серверное мобильное приложение для планирования дедлайнов на платформе Android",
        "description": "Доработка проекта PossumPlanner, созданного на ПИ ФКН в 2021 году. Требуется наладить работу приложения и добавить серверную часть",
        "project_type": "Проектный",
        "supervisor": "Зубарева Наталия Дмитриевна",
        "number_of_students": 2,
        "submission_deadline": "2024-01-01",
        "application_deadline": "2023-08-01",
        "application_form": "@HolisticProgramming",
        "status": "набор открыт"
    }
]    

* projects/int:pk/ - просмотр, редактирование, удаление конкретного проекта

GET запрос для получения информации, возвращающий объект 

    {
        "id": 4,
        "title": "Приложение для интраоперационного мультилингвального картирования речи",
        "description": "Приложение для автоматизации процесса проведения теста на называние - процедуры, проводимой во время операций на мозге с целью предотвращения потери речи. Требуется разработать кроссплатформенное мобильное приложение (в первой версии для платформы Android), которое бы позволяло добавлять пациентов для тестирования, проводить тестирование (с показом изображений, записью ответов тестируемого), проверять ответы.",
        "project_type": "Проектный",
        "supervisor": "Зонтов Юрий Владимирович",
        "number_of_students": 1,
        "submission_deadline": "2023-08-01",
        "application_deadline": "2022-10-01",
        "application_form": "https://www.hse.ru/neuroling/",
        "status": "набор завершен"
    }

PUT запрос для редактирования в формате

    {
        "title": "Приложение для интраоперационного мультилингвального картирования речи",
        "description": "Приложение для автоматизации процесса проведения теста на называние - процедуры, проводимой во время операций на мозге с целью предотвращения потери речи. Требуется разработать кроссплатформенное мобильное приложение (в первой версии для платформы Android), которое бы позволяло добавлять пациентов для тестирования, проводить тестирование (с показом изображений, записью ответов тестируемого), проверять ответы.",
        "project_type": "Проектный",
        "supervisor": "Зонтов Юрий Владимирович",
        "number_of_students": 1,
        "submission_deadline": "2023-08-01",
        "application_deadline": "2022-10-01",
        "application_form": "https://www.hse.ru/neuroling/",
        "status": "набор завершен"
    }

DELETE запрос формата

    {
        "id": 4,
        "title": "Приложение для интраоперационного мультилингвального картирования речи",
        "description": "Приложение для автоматизации процесса проведения теста на называние - процедуры, проводимой во время операций на мозге с целью предотвращения потери речи. Требуется разработать кроссплатформенное мобильное приложение (в первой версии для платформы Android), которое бы позволяло добавлять пациентов для тестирования, проводить тестирование (с показом изображений, записью ответов тестируемого), проверять ответы.",
        "project_type": "Проектный",
        "supervisor": "Зонтов Юрий Владимирович",
        "number_of_students": 1,
        "submission_deadline": "2023-08-01",
        "application_deadline": "2022-10-01",
        "application_form": "https://www.hse.ru/neuroling/",
        "status": "набор завершен"
    }

##### Работа со связями:

* application_create/ -	создание заявки на проект, 

POST запрос формата

    {
        "project_id": 13,
        "student_id": 19,
        "status": "Заявка отменена"
    }

* applications/	- просмотр всех заявок, GET запрос формата 
\[

    {
        "id": 65,
        "project_id": 10,
        "student_id": 19,
        "status": "Подана заявка"
    },
    {
        "id": 66,
        "project_id": 4,
        "student_id": 19,
        "status": "Заявка отменена"
    }
]

* applications/int:pk/	- просмотр, редактирование, удаление конкретной заявки

GET запрос для получения информации, возвращающий объект 

    {
        "id": 67,
        "project_id": 13,
        "student_id": 19,
        "status": "Заявка отменена"
    }

PUT запрос для редактирования в формате

    {
        "project_id": 13,
        "student_id": 19,
        "status": "Заявка отменена"
    }

DELETE запрос формата

    {
        "id": 67,
        "project_id": 13,
        "student_id": 19,
        "status": "Заявка отменена"
    }

* requirements_stack_create/ - сопоставление тега и проекта, 

POST запрос формата

    {
        "project_id": 4,
        "requirement_id": 2
    }

* requirements_stacks/ - список тегов по проектам, 

GET запрос формата 

\[

    {
        "id": 2,
        "project_id": 4,
        "requirement_id": 2
    },
    {
        "id": 3,
        "project_id": 4,
        "requirement_id": 3
    }
]

* requirements_stacks/int:pk/ -	просмотр, редактирование, удаление конкретной связи

GET запрос для получения информации, возвращающий объект 

    {
        "id": 2,
        "project_id": 4,
        "requirement_id": 2
    }

PUT запрос для редактирования в формате

    {
        "project_id": 4,
        "requirement_id": 2
    }

DELETE запрос формата

    {
        "id": 2,
        "project_id": 4,
        "requirement_id": 2
    }

* student_interest_create/ - создание интереса у студента, 

POST запрос формата

    {
        "student_id": 18,
        "interest_id": 11
    }

* student_interests/ - список всех интересов у всех студентов,

GET запрос формата 

\[

    {
        "id": 112,
        "student_id": 18,
        "interest_id": 11
    },
    {
        "id": 113,
        "student_id": 18,
        "interest_id": 35
    }
]

* student_interests/int:pk/ - просмотр конкретной связи

GET запрос для получения информации, возвращающий объект 

    {
        "id": 112,
        "student_id": 18,
        "interest_id": 11
    }

PUT запрос для редактирования в формате

    {
        "student_id": 18,
        "interest_id": 11
    }

DELETE запрос формата

    {
        "id": 112,
        "student_id": 18,
        "interest_id": 11
    }

* suggestions_create/ -	создание рекомендации,
 
POST запрос формата


    {
        "project_id": 8,
        "student_id": 19
    }

* suggestions/ - просмотр всех рекомендаций, GET запрос формата 

\[

    {
        "id": 128,
        "project_id": 8,
        "student_id": 19
    },
    {
        "id": 129,
        "project_id": 4,
        "student_id": 19
    }
]

* suggestions/int:pk/ -	просмотр, редактирование, удаление конкретной рекомендации 

GET запрос для получения информации, возвращающий объект 

    {
        "id": 128,
        "project_id": 8,
        "student_id": 19
    }

PUT запрос для редактирования в формате

    {
        "project_id": 8,
        "student_id": 19
    }

DELETE запрос формата

    {
        "id": 128,
        "project_id": 8,
        "student_id": 19
    }

##### Срезы:
* requirements_by_project/int:pk/ -	список тегов-требований по конкретному проекту, GET запрос формата

\[

    {
        "project_id": 4,
        "id": 2,
        "name": "Прикладной проект"
    },
    {
        "project_id": 4,
        "id": 3,
        "name": "Фронтенд"
    }
]   

* applications_by_student/int:pk/ -	список заявок по конкретному студенту, GET запрос формата

\[

    {
        "id": 5,
        "title": "Клиент-серверное мобильное приложение для планирования дедлайнов на платформе Android",
        "description": "Доработка проекта PossumPlanner, созданного на ПИ ФКН в 2021 году. Требуется наладить работу приложения и добавить серверную часть",
        "project_type": "Проектный",
        "supervisor": "Зубарева Наталия Дмитриевна",
        "number_of_students": 2,
        "submission_deadline": "2024-01-01",
        "application_deadline": "2023-08-01",
        "application_form": "@HolisticProgramming",
        "status": "набор открыт"
    },
    {
        "id": 7,
        "title": "IOS приложение цифровой ассистент студента",
        "description": "Разработка клиент-серверного мобильного приложения для IOS - цифрового ассистента студентов, предназначенного для решения проблемы поиска студентами проектов для учебных курсов. Приложение должно предоставлять агрегированные описания проектов, которые студенты смогут просматривать и выбирать в соответствии со своими интересами с помощью системы рекомендаций.",
        "project_type": "Проектный",
        "supervisor": "Паринов Андрей Андреевич",
        "number_of_students": 4,
        "submission_deadline": "2023-04-01",
        "application_deadline": "2022-10-01",
        "application_form": "контакты на сайте вшэ",
        "status": "набор завершен"
    }
]

* interests_by_student/int:pk/ - список тегов-интересов по конкретному студенту, 
GET запрос формата

\[
  
    {
        "id": 18,
        "interest_id": 11,
        "name": "Биология"
    },
    {
        "id": 18,
        "interest_id": 35,
        "name": "Android"
    }
]

* information_by_student/int:pk/ -	подробная информация по конкретному студенту, 
GET запрос формата

\[
  
    {
        "id": 18,
        "email": "ndzubareva@edu.hse.ru",
        "faculty": "ФКН",
        "group": "БПИ195",
        "name": "Наталия Зубарева",
        "phone_number": "3116293047",
        "year": 4
    }
]

* student_suggestions/int:pk/ -	все рекомендации по конкретному студенту, GET запрос формата

[

    {
        "id": 5,
        "title": "Клиент-серверное мобильное приложение для планирования дедлайнов на платформе Android",
        "description": "Доработка проекта PossumPlanner, созданного на ПИ ФКН в 2021 году. Требуется наладить работу приложения и добавить серверную часть",
        "project_type": "Проектный",
        "supervisor": "Зубарева Наталия Дмитриевна",
        "number_of_students": 2,
        "submission_deadline": "2024-01-01",
        "application_deadline": "2023-08-01",
        "application_form": "@HolisticProgramming",
        "status": "набор открыт"
    },
    {
        "id": 4,
        "title": "Приложение для интраоперационного мультилингвального картирования речи",
        "description": "Приложение для автоматизации процесса проведения теста на называние - процедуры, проводимой во время операций на мозге с целью предотвращения потери речи. Требуется разработать кроссплатформенное мобильное приложение (в первой версии для платформы Android), которое бы позволяло добавлять пациентов для тестирования, проводить тестирование (с показом изображений, записью ответов тестируемого), проверять ответы.",
        "project_type": "Проектный",
        "supervisor": "Зонтов Юрий Владимирович",
        "number_of_students": 1,
        "submission_deadline": "2023-08-01",
        "application_deadline": "2022-10-01",
        "application_form": "https://www.hse.ru/neuroling/",
        "status": "набор завершен"
    }
]


### [Руководство по эксплуатации конечными пользователями](https://github.com/aparinov/2023_DSA_iOS/blob/main/%D0%A0%D1%83%D0%BA%D0%BE%D0%B2%D0%BE%D0%B4%D1%81%D1%82%D0%B2%D0%BE%20%D0%BF%D0%BE%20%D1%8D%D0%BA%D1%81%D0%BF%D0%BB%D1%83%D0%B0%D1%82%D0%B0%D1%86%D0%B8%D0%B8%20%D0%BA%D0%BE%D0%BD%D0%B5%D1%87%D0%BD%D1%8B%D0%BC%D0%B8%20%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8F%D0%BC%D0%B8.md)
___________________________________________________________________________________________________________
Над системой работали:

[Зубарева Наталия](https://github.com/HowToCodeWithPaws)

[Мостачев Андрей](https://github.com/AndrewMOST)

[Поволоцкий Виктор](https://github.com/Tramatusin)

[Сальникова Алиса](https://github.com/Teytid)

2023
