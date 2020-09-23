# How starting a new Django project with Cookiecutter

## Install Cookiecutter
`$ pip install cookiecutter`

## Create a new project
`$ cookiecutter gh:pydanny/cookiecutter-django`

## Fill generator options
*Cookiecutter* gives us a set of pre-defined configurations to include at our project. Each configuration depends on each project that you will be involved in. You can take a look at [the full list of generation options](https://cookiecutter-django.readthedocs.io/en/latest/project-generation-options.html).

Despite the previously mentioned, we provide you a list of the principal configuration that you have to set in a new *Cookiecutter* project.

NOTE:
- Each option suggests a default value if you agree with it, just press enter.

Some interesting options:
- **project_name**: Write the name of the new project using an upper case at the beginning. For ex.: Cookiecutter Starter.
- **project_slug**: Write the name of the new project using downcases and underscores. At Rootstrap we use the same name of the code repository. For ex.: cookiecutter_starter.
- **description**: Write a short description of the new project. Remember to add it to the readme file. For ex.: This project is an example of how to configure a Django project from the beginning with Cookiecutter Django
- **author_name**: Write the company name. For ex.: Rootstrap, Inc.
- **domain_name**: Write the customer domain name. For ex.: example.com
- **email**: Write the customer email contact. For ex.: info@example.com
- **open_source_license**: Choose the License according to the final purpose of the project. If it's an open-source project, you should select the option `1` (MIT). But if it's a client project, you should select the option `5` (Not open source).
- **windows**: This option asks us if we want to be able to develop at Windows environment. At Rootstrap we use Linux ones, so, you should enter the option: `n`.
- **use_pycharm**: This option asks us if we want to add some configuration files to run the project at PyCharm, the Jetbrains' Python IDE. It's personal, choose `n` or `y` according to your preferences.
- **cloud_provider**: Choose the cloud provider for files resources that will be attached from the models. At Rootstrap we use AWS, so, you should select option `1`.
- **mail_service**: Choose the email service for send emails from the application. At Rootstrap we use Sendgrid, so, you should select option `6`.
- **use_drf**: This option asks us if we want to add [Django REST framework](https://www.django-rest-framework.org/) to our application. At Rootstrap we use it as the base of our API, so, you should enter the option: `y`.
- **use_mailhog**: This option asks us if we want to add [Mailhog](https://github.com/mailhog/MailHog) as an email viewer during the development process. We recommend that option, so, you should enter: `y`.
- **use_heroku**: This option asks us if we want to add some configuration files to deploy the project to *Heroku*. At Rootstrap we usually deploy to it, so, you should enter: `y`.
- **keep_local_envs_in_vcs**: This option asks us if we want to add the environment configurations to the Version Control System. Also, it's useful to set Heroku or docker variables. AAt Rootstrap we manage that information differently, so, you should enter: `n`.

<details>
  <summary>View full bash output. <i>(Click &#x25B6; to display the file)</i></summary>

```bash
project_name [My Awesome Project]: Cookiecutter Starter
project_slug [cookiecutter_starter]:
description [Behold My Awesome Project!]: This proyect is an example of how configure a Django proyect since beginning
author_name [Daniel Roy Greenfeld]: Rootstrap, Inc.
domain_name [example.com]: example.com
email [rootstrap@example.com]: info@example.com
version [0.1.0]:
Select open_source_license:
1 - MIT
2 - BSD
3 - GPLv3
4 - Apache Software License 2.0
5 - Not open source
Choose from 1, 2, 3, 4, 5 [1]: 1
timezone [UTC]:
windows [n]:
use_pycharm [n]:
use_docker [n]:
Select postgresql_version:
1 - 12.3
2 - 11.8
3 - 10.8
4 - 9.6
5 - 9.5
Choose from 1, 2, 3, 4, 5 [1]: 1
Select js_task_runner:
1 - None
2 - Gulp
Choose from 1, 2 [1]:
Select cloud_provider:
1 - AWS
2 - GCP
3 - None
Choose from 1, 2, 3 [1]: 1
Select mail_service:
1 - Mailgun
2 - Amazon SES
3 - Mailjet
4 - Mandrill
5 - Postmark
6 - Sendgrid
7 - SendinBlue
8 - SparkPost
9 - Other SMTP
Choose from 1, 2, 3, 4, 5, 6, 7, 8, 9 [1]: 6
use_async [n]:
use_drf [n]: y
custom_bootstrap_compilation [n]: n
use_compressor [n]:
use_celery [n]:
use_mailhog [n]: y
use_sentry [n]:
use_whitenoise [n]:
use_heroku [n]: y
Select ci_tool:
1 - None
2 - Travis
3 - Gitlab
Choose from 1, 2, 3 [1]:
keep_local_envs_in_vcs [y]: n
debug [n]:
```

</details>

## Install pipenv
The recommendation from Rootstrap is that you use `pipenv` to manage the development environment dependencies.

To install the package, just run `$ pip install pipenv`.

## Install dependencies
To install the dev dependencies, run `$ pipenv install -r requirements/local.txt --dev`.

NOTE:
- Remember, when you install a new dependency, check if it will be needed at production or not. In the case that it won't be needed, add the flag `--dev` at the end of the installation command.
- At pipenv to run a command, you must write before `pipenv run`, for example, the command that runs the server should be `$ pipenv run python manage.py runserver`.

## Create psql database
`$ createdb cookiecutter_starter-dev`

## Load .env file for local configurations
1. At `config/settings/base.py` set `DJANGO_READ_DOT_ENV_FILE` to load the configurations from `.env` file.
```python
#  config/settings/base.py

#  Before
READ_DOT_ENV_FILE = env.bool("DJANGO_READ_DOT_ENV_FILE", default=False)

#  After
READ_DOT_ENV_FILE = env.bool("DJANGO_READ_DOT_ENV_FILE", default=True)
```

2. Create `.env` file at root folder and `.env.example` to track the local configuration needed.
```yml
#  .env.example

DJANGO_DEBUG=on
DATABASE_URL=postgres://<user>:<password>@localhost:5432/cookiecutter_starter-dev
```

## Migrate
`$ pipenv run python manage.py migrate`

## Run test
`$ pipenv run pytest`

## Run test and get coverage percentage
`$ pipenv run coverage run -m pytest && pipenv run coverage report -m`

NOTE:
- The command must run without exceptions because it mandatory for future configurations.
- Don't matter if you write tests following the [unittest](https://docs.python.org/3/library/unittest.html) or [pytest](https://docs.pytest.org/) approach since `$ pipenv run pytest` command will be able to run both of them.

## Install Mailhog
`$ brew install mailhog`

NOTE: If you prefer other options to install *Mailhog*, you can take a look at the [Mailhog installation guideline](https://github.com/mailhog/MailHog#installation).

Start the server running `$ mailhog`

Finally, if you go to `http://localhost:8025/`, your mail server is running.

## Code Style
### [flake8](https://flake8.pycqa.org/) and [flake8-isort](https://github.com/gforcada/flake8-isort)
*NOTE: By default this package is already installed.*

1. `$ pipenv install flake8 flake8-isort --dev`
1. Add dependencies to requirement files. Below the *Code quality* separator:
```
flake8==<version>
flake8-isort==<version>
```
3. Add custom configuration at `setup.cfg` file according to the Rootstrap's standards.
    - **extend-ignore**: exclude flake8 warnings to avoid black conflicts. [See more.](https://black.readthedocs.io/en/stable/compatible_configs.html#id2)
```yml
#  setup.cfg

[flake8]
max-line-length = 120
exclude = .tox,.git,*/migrations/*,*/static/CACHE/*,docs,node_modules,venv/*
extend-ignore = E203, W503
```
4. Check running `$ pipenv run flake8`.
    - This command list all the issues found.
    - A useful command could be `$ pipenv run isort .` which resolves all the issues related to import styles. Also, you can add the flag `--interactive` at the end of the command to resolve or ignore one issue by one.

### [black](https://black.readthedocs.io/)
*NOTE: By default this package is already installed.*

1. `$ pipenv install black --dev`
1. Add dependencies to requirement files. Below the *Code quality* separator:
```
black==<version>
```
3. Add custom configuration at `pyproject.toml` file according to the Rootstrap's standards.
    - *black* does not support configurations at `setup.cfg` file and there isn't a plan to do it in the future. [See more.](https://github.com/psf/black/issues/683)
```yml
#  pyproject.toml

[tool.black]
skip_string_normalization = true
line-length = 120
exclude = '.*\/(migrations|settings)\/.*'
```
4. Check running `$ pipenv run black . --check`.
    - This command list all the issues found.
    - A useful command could be `$ pipenv run black .` which resolves all the issues. Also, you can run `$ pipenv run black . --diff` to watch the proposed changes.

### Single-quotes
> *Here at Rootstrap we prefer to use single-quoted strings over double quotes. For docstrings we use double quotes since the chance of writing a ' is higher in the documentation string of a class or a method.*
>
> [Rootstrap Guides/Python/String Quotes](https://github.com/rootstrap/tech-guides/tree/master/python#string-quotes)

To convert the existing double quotes to single ones, follow these steps:
1. In your IDE, search by the regex `/(?<!"")(?<=(?!""").)"(?!"")/`.
1. Replace the occurrences with the single quote `'`.
1. Include only the python files: `*.py`.
1. Exclude migrations files: `*migrations*`.
1. Check that everything is well replaced.

The VS Code configuration:
- **Search**: `(?<!"")(?<=(?!""").)"(?!"")`
- **Replace**: `'`
- **files to include**: `*.py`
- **files to exclude**: `*migrations*`


## CI

### Code Climate
1. Set up the project at CodeClimate. [guide](https://docs.codeclimate.com/docs/getting-started-with-code-climate)
1. Find your `Test Coverage ID` at CodeClimate to complete the next configuration. [guide](https://docs.codeclimate.com/docs/finding-your-test-coverage-token)
1. Follow one of the following configurations *Circle CI* or *GitHub Action*.

### Circle CI
1. Set up the project at CircleCI. [guide](https://circleci.com/docs/2.0/getting-started/#setting-up-circleci)
1. Create the folder `.circleci` and inner it the file `config.yml` with the following content.
1. Create an environment variable to know where sends the CodeClimate report. [guide](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project)
    - Name: `CC_TEST_REPORTER_ID`
    - Value: `Test Coverage ID`
1. Add badge to readme file. [guide](https://circleci.com/docs/2.0/status-badges/)
```markdown
# Template:
.. image:: https://circleci.com/<VCS>/<ORG_NAME>/<PROJECT_NAME>.svg?style=svg
    :target: https://circleci.com/<VCS>/<ORG_NAME>/<PROJECT_NAME>

# Example:
.. image:: https://circleci.com/gh/afmicc/cookiecutter_starter.svg?style=shield
    :target: https://circleci.com/gh/afmicc/cookiecutter_starter
    :alt: Tests status
```

<details>
  <summary>.circleci/config.yml. <i>(Click &#x25B6; to display the file)</i></summary>

```yml
#  .circleci/config.yml

version: 2.1

jobs:
  build:
    docker:
      - image: circleci/python:latest
        environment:
          DATABASE_URL: postgresql://postgres:@localhost:5432/circle_test?sslmode=disable

      - image: circleci/postgres:alpine-postgis-ram

    steps:
      - checkout
      - run:
          name: Installing resoruces
          command: |
            pip install --upgrade pip==20.0.2
            pip install pipenv

      - restore_cache:
          keys:
            - venv-requirements-{{ checksum "Pipfile.lock" }}
            - venv-requirements-

      - run:
          name: Installing pip requirements
          command: |
            pipenv install --dev

      - run:
          name: Checking PEP8 code style
          command: |
            pipenv run flake8 --count

      - run:
          name: Checking Black code formatter
          command: |
            pipenv run black . --check

      - run:
          name: Running tests
          command: |
            pipenv run coverage run -m pytest --ds=config.settings.test

      - save_cache:
          key: venv-requirements-{{ checksum "Pipfile.lock" }}
          paths:
            - ".venv"

      - run:
          name: Checking coverage
          command: |
            pipenv run coverage report --fail-under=90 -m
            pipenv run coverage xml

      - run:
          name: Setup Code Climate test-reporter
          command: |
            curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
            chmod +x ./cc-test-reporter
            ./cc-test-reporter before-build
            ./cc-test-reporter after-build --coverage-input-type coverage.py --exit-code $?
```

</details>

**Extra**: If you want, you can run CircleCI locally.
1. Install the [CircleCI CLI](https://circleci.com/docs/2.0/local-cli-getting-started/#section=getting-started)
1. Run the command to generate the `process.yml` file: `$ circleci config process .circleci/config.yml > process.yml`.
1. Finally execute it: `$ circleci local execute -c process.yml --job build`.
1. *(Optional)* Add `process.yml` to `.gitignore`.

```
# .gitignore

### Continuous Integration

process.yml

```

### GitHub Workflow

1. Create the path `.github/workflows` and inner it the file `python-app.yml` with the following content.
1. Create a project secret to use it at the config file. [guide](https://docs.github.com/en/actions/reference/encrypted-secrets#creating-encrypted-secrets-for-a-repository).
    - Name: `CC_TEST_REPORTER_ID`
    - Value: `Test Coverage ID`
1. Add badge to readme file. [guide](https://docs.github.com/en/actions/managing-workflow-runs/adding-a-workflow-status-badge#using-the-event-parameter)
    - The workflow name is the value of the first configuration `name`, in the example above is `Python application`.

```markdown
# Template:
.. image:: https://github.com/<OWNER>/<REPOSITORY>/workflows/<WORKFLOW_NAME>/badge.svg

# Example:
.. image:: https://github.com/afmicc/cookiecutter_starter/workflows/Python%20application/badge.svg
    :alt: Tests status
```

<details>
  <summary>.github/workflows/python-app.yml. <i>(Click &#x25B6; to display the file)</i></summary>

```yml
#  .github/workflows/python-app.yml

name: Python application

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest
    services:
      db:
        image: postgres:11.6-alpine
        env:
          POSTGRES_PASSWORD: postgres
          POSTGRES_USER: postgres
        ports:
          - "5432:5432"
    env:
      DATABASE_URL: postgresql://postgres:postgres@localhost:5432/postgres
      CC_TEST_REPORTER_ID: ${{ secrets.CC_TEST_REPORTER_ID }}

    steps:
    - uses: actions/checkout@v2

    - name: Set up Python 3.8
      uses: actions/setup-python@v2
      with:
        python-version: 3.8

    - name: Installing resoruces
      run: |
        pip install --upgrade pip==20.0.2
        pip install pipenv

    - name: Cache pipenv
      uses: actions/cache@v2
      id: cache-venv
      with:
        path: ./.venv
        key: ${{ runner.os }}-venv-${{ hashFiles('Pipfile.lock') }}
        restore-keys: |
          ${{ runner.os }}-venv-

    - name: Installing requirements
      run: |
        pipenv install --dev

    - name: Checking PEP8 code style
      run: |
        pipenv run flake8 --count

    - name: Checking Black code formatter
      run: |
        pipenv run black . --check

    - name: Running tests
      run: |
        pipenv run coverage run -m pytest --ds=config.settings.test

    - name: Checking coverage
      run: |
        pipenv run coverage report --fail-under=90 -m
        pipenv run coverage xml

    - name: Setup Code Climate test-reporter
      run: |
          curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
          chmod +x ./cc-test-reporter
          ./cc-test-reporter before-build
          ./cc-test-reporter after-build --coverage-input-type coverage.py --exit-code $?
```

</details>

## Adding a new app

1. To create a new app into the project, we have to run the command `$ pipenv run python manage.py startapp <new_app_name>`.
    - **new_app_name**: is the name of the new app and it has to be written in plural. For example: targets
1. Since that command creates the new app at the root directory, you have to move it to `<project_name>` directory, where there are other existing apps like `users`.
    - **project_name**: is the name that you define in the first step of the project creation. For example: cookiecutter_starter
1. Other change is needed, you have to edit the `apps.py` file of the new app and replace the current `name` field of the config class from only `<new_app_name>` to `<project_name>.<new_app_name>`.
```python
# cookiecutter_starter/targets/apps.py

# Before

class TargetsConfig(AppConfig):
    name = 'targets'

# After

class TargetsConfig(AppConfig):
    name = 'cookiecutter_starter.targets'
```
4. Finally, you need to add the created app to the `INSTALLED_APPS` configuration. We need to go to the file `config/settings/base.py` and find the `LOCAL_APPS` variable where we should add our recently created app following this pattern: `<project_name>.<new_app_name>.apps.<NameOfTheNewAppConfigClass>`. As we can see in the following example, the `LOCAL_APPS` is concatenated to other required apps to create the recognized `INSTALLED_APPS` variable, this is just a splitting that applies Cookiecutter to improve the organization of the app in the config files.
```python
# config/settings/base.py
...

LOCAL_APPS = [
    'cookiecutter_starter.users.apps.UsersConfig',
    # Your stuff: custom apps go here
    'cookiecutter_starter.targets.apps.TargetsConfig',
]

INSTALLED_APPS = DJANGO_APPS + THIRD_PARTY_APPS + LOCAL_APPS

...
```

### Solution Structure

The internal organization of the structure of an app could depend on the different requirements and circumstances that you have to solve. At Rootstrap, we provide a recommended structure which you could follow whenever you can.

<details>
  <summary>Structure. <i>(Click &#x25B6; to display the file)</i></summary>

```
<project_name>
├── config
│   ├── settings
│   │   ├── ...
│   │   ├── base.py - Here is the base.py file that we mentioned before
│   │   ├── local.py
│   │   ├── production.py
│   │   └── test.py
│   ├── urls.py
│   └── ...
├── <project_name> - Where you place new apps
│   ├── templates
│   │   ├── <new_app_name>
│   │   │   └── <model_name>_form.html
│   │   ├── users
│   │   │   └── ...
│   │   ├── ...
│   │   ├── 403.html
│   │   ├── 404.html
│   │   ├── 500.html
│   │   └── base.html
│   ├── <new_app_name>
│   │   ├── api
│   │   │   ├── serializers.py
│   │   │   └── views.py
│   │   ├── migrations
│   │   │   └── ...
│   │   ├── tests
│   │   │   ├── __init__.py
│   │   │   ├── factories.py
│   │   │   ├── test_forms.py
│   │   │   ├── test_models.py
│   │   │   ├── test_urls.py
│   │   │   └── test_views.py
│   │   ├── utils
│   │   │   └── ...
│   │   ├── __init__.py
│   │   ├── admin.py
│   │   ├── apps.py - Here is the apps.py file that we mentioned before
│   │   ├── forms.py
│   │   ├── models.py
│   │   ├── urls.py
│   │   └── views.py
│   ├── users
│   │   └── ...
│   └── ...
├── ...
└── manage.py
```

</details>


## Final

Congratulations! Your project is fully configured 💪

Here the example project: [afmicc/cookiecutter_starter](https://github.com/afmicc/cookiecutter_starter)
