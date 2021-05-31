# How to start a new Django project with Cookiecutter
The aim of this guide is to help you to initialize your Django project from one of the most recognized open-source utilities for this area.

## Install Cookiecutter
[*Cookiecutter*](https://github.com/cookiecutter/cookiecutter) is a command-line tool that helps us to create projects from different templates, in our case, we will create a Django project.

Firstly, we have to globally install that tool running `$ pip install cookiecutter`

## Create a new project
Since we want to create a Django project, we need to use the [Cookiecutter Django](https://github.com/pydanny/cookiecutter-django) template.

Go to your development directory (the location where you want to create the root folder of the project) and run the following command to start the creation:
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
- **keep_local_envs_in_vcs**: This option asks us if we want to add the environment configurations to the Version Control System. Also, it's useful to set Heroku or docker variables. At Rootstrap we manage that information differently, so, you should enter: `n`.

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
  
  
Note: By default the root folder of the project generated will be equal to the entered project_slug, that is, the name of the main Django app. After this process, you can change the root folder project name if you want.

## Install pipenv
The recommendation from Rootstrap is that you use [`pipenv`](https://github.com/pypa/pipenv) to manage the development environment dependencies.

To install the package globally, just run `$ pip3 install pipenv`

## Install dependencies
In order to use pipenv and avoid confusions we are going to generate a Pipfile with the existing requirements and then remove all "requirements.txt" type of files.

1. Install the main dependencies: `$ pipenv install -r requirements/production.txt`
2. Open `requirements/local.txt` and delete the first line: `-r base.txt`. This will prevent the duplication of all base dependencies under `[dev-packages]` in the Pipfile.
3. Install dev dependencies: `$ pipenv install -r requirements/local.txt --dev`
4. Delete the following files and folder:
  - `requirements.txt` from the root folder of the project.
  - `requirements/base.txt`, `requirements/local.txt`, `requirements/production.txt` and the `requirements` folder.

NOTE:
- Remember, when you install a new dependency, check if it will be needed at production or not. In the case that it won't be needed, add the flag `--dev` at the end of the installation command.
- At `pipenv` to run a command, you have two options:
    1. You can run `$ pipenv shell`, which creates a shell with the virtual environment activated, and in there, you can run any command without prefixes. For example, the command that runs the server should be just `$ python manage.py runserver`
    2. If you haven't entered to the shell, you can write `pipenv run` before any command, for example, the command that runs the server should be `$ pipenv run python manage.py runserver`

## Create psql database
`$ createdb <db-name>`  

For example `$ createdb cookiecutter_starter-db-dev`

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
DATABASE_URL=postgres://<user>:<password>@localhost:5432/<db-name>
```

For example, let's say you have:
- A created db named `cookiecutter_starter-db-dev`, and a user `postgres` with password `postgres` 
- Then the value for `DATABASE_URL` would be: `DATABASE_URL=postgres://postgres:postgres@localhost:5432/cookiecutter_starter-db-dev`

### Important Note
For the next commands, we will assume that you are in the root folder, and you have already entered to the sell with `$ pipenv shell`

## Migrate
`$ python manage.py migrate`

## Run test
`$ pytest`

## Run test and get coverage percentage
`$ coverage run -m pytest && pipenv run coverage report -m`

NOTE:
- The command must run without exceptions because it's mandatory for future configurations.
- Don't matter if you write tests following the [unittest](https://docs.python.org/3/library/unittest.html) or [pytest](https://docs.pytest.org/) approach since `$ pytest` command will be able to run both of them.

## Install Mailhog
`$ brew install mailhog`

NOTE: If you prefer other options to install *Mailhog*, you can take a look at the [Mailhog installation guideline](https://github.com/mailhog/MailHog#installation).

Start the server running `$ mailhog`

Finally, if you go to `http://localhost:8025/`, your mail server is running.

## Code Style
### [flake8](https://flake8.pycqa.org/) and [flake8-isort](https://github.com/gforcada/flake8-isort)
*NOTE: By default this package is already installed.*

1. `$ pipenv install flake8 flake8-isort --dev`
2. Add custom configuration at `setup.cfg` file according to the Rootstrap's standards.
    - **extend-ignore**: exclude flake8 warnings to avoid black conflicts. [See more.](https://black.readthedocs.io/en/stable/compatible_configs.html#id2)
```yml
#  setup.cfg

[flake8]
max-line-length = 120
exclude = .tox,.git,*/migrations/*,*/static/CACHE/*,docs,node_modules,venv/*
extend-ignore = E203, W503
```
3. Check running `$ flake8 .`
    - This command list all the issues found.
    - A useful command could be `$ isort .` which resolves all the issues related to import the styles. Also, you can add the flag `--interactive` at the end of the command to resolve or ignore one issue by one.

### [black](https://black.readthedocs.io/)
*NOTE: By default this package is already installed.*

1. `$ pipenv install black --dev`
2. Add custom configuration creating a `pyproject.toml` file in the root folder according to the Rootstrap's standards and adding the next configuration.
    - *black* does not support configurations at `setup.cfg` file and there isn't a plan to do it in the future. [See more.](https://github.com/psf/black/issues/683)
```yml
#  pyproject.toml

[tool.black]
skip_string_normalization = true
line-length = 120
exclude = '.*\/(migrations|settings)\/.*'
```
3. Check running `$ black . --check`
    - This command list all the issues found.
    - A useful command could be `$ black .` which resolves all the issues. Also, you can run `$ black . --diff` to watch the proposed changes.

### If you want to have this in a new Github repository
If you want to have this project in a new Github repository under the rootstrap organization, then follow these steps:
1. Go to Github.
2. Click on create new repository.
3. Under Owner, select rootstrap.
4. Write the name for the respository equal to the name of the root folder of the project created with DjangoCookieCutter.
5. Copy the `git clone with ssh value` from the project.
6. Go to the root folder project in your terminal.
7. Run `$ git init`
8. Run `$ git remote add origin <git clone with ssh value>`
9. If your current branch hasn't the `main` branch, then run `$ git checkout -b main`
10. Run `$ git add .`
11. Run `$ git commit -m "First commit"`. You can change the `"First commit"` message with whatever you think is correct.
12. Run `$ git push origin main`
13. If you had to run `$ git checkout -b main` then now run `$ git branch -M main`

### [pre-commit](https://pre-commit.com/)
*NOTE: By default this package is already installed.*

This is optional and is a local configuration. A sample `pre-commit-config` hook already exists in the generated project as default.
1. `$ pipenv install pre-commit --dev`
2. `$ pre-commit install` # A git repo is required for pre-commit to install

This will run flake8, black and isort locally before creating a commit. This can avoid having to wait for the CI to fail to remember that we missed some styling issues. You can ignore the pre commit hook by adding `-n` when creating a commit (e.g. `git commit -m 'ignore pre-commit' -n`). 

You can check the `.pre-commit-config.yaml` file for more details.

Note: the first commit after running step 2 will take a while but after that it will be pretty fast.

### Single-quotes
> *Here at Rootstrap we prefer to use single-quoted strings over double quotes. For docstrings we use double quotes since the chance of writing a ' is higher in the documentation string of a class or a method.*
>
> [Rootstrap Guides/Python/String Quotes](https://github.com/rootstrap/tech-guides/tree/master/python#string-quotes)

To convert the existing double quotes to single ones, follow these steps:
1. In your IDE, search by the regex `/(?<!"")(?<=(?!""").)"(?!"")/`
2. Replace the occurrences with the single quote `'`
3. Include only the python files: `*.py`
4. Exclude migrations files and manage.py: `*migrations*, manage.py`
5. Check that everything is well replaced.

The VS Code configuration:
- **Search**: `(?<!"")(?<=(?!""").)"(?!"")`
- **Replace**: `'`
- **files to include**: `*.py`
- **files to exclude**: `*migrations*, manage.py`


## CI

### Code Climate
1. Set up the project at CodeClimate. [guide](https://docs.codeclimate.com/docs/getting-started-with-code-climate)
2. Find your `Test Coverage ID` at CodeClimate to complete the next configuration. [guide](https://docs.codeclimate.com/docs/finding-your-test-coverage-token)
3. Follow one of the these configurations: *Circle CI* or *GitHub Action*.
4. Create a `.codeclimate.yml` configuration file in the root of the project using the following content as a starter to avoid analyzing unnecessary files like tests and migrations.

<details>
  <summary>.codeclimate.yml. <i>(Click &#x25B6; to display the file)</i></summary>

```yml
#  .codeclimate.yml
version: "2"

checks:
  argument-count:
    config:
      threshold: 5 # Allow at most 5 arguments in a function
  method-count:
    config:
      threshold: 25 # Allow at most 25 functions in a class

exclude_patterns:
  - "**/migrations/**"
  - "**/settings/**"
  - "docs/"
  - "**/*.env"
  - "build/"
  - "dist/"
  - "**__pycache__**"

plugins:
  pep8:
    enabled: true
  duplication:
    enabled: true
    exclude_patterns:
      - "**/tests/**" # Don't check duplication on tests
```
</details>


### Circle CI
1. Set up the project at CircleCI. [guide](https://circleci.com/docs/2.0/getting-started/#setting-up-circleci)
2. Create the folder `.circleci` and inner it the file `config.yml` with the following content.
3. Create an environment variable to know where sends the CodeClimate report. [guide](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project)
    - Name: `CC_TEST_REPORTER_ID`
    - Value: `Test Coverage ID`
4. Add badge to readme file. [guide](https://circleci.com/docs/2.0/status-badges/)
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
2. Run the command to generate the `process.yml` file: `$ circleci config process .circleci/config.yml > process.yml`
3. Finally execute it: `$ circleci local execute -c process.yml --job build`
4. *(Optional)* Add `process.yml` to `.gitignore`

```
# .gitignore

### Continuous Integration

process.yml

```

### GitHub Workflow

1. Create the path `.github/workflows` and inner it the file `python-app.yml` with the following content.
2. Create a project secret to use it at the config file. [guide](https://docs.github.com/en/actions/reference/encrypted-secrets#creating-encrypted-secrets-for-a-repository).
    - Name: `CC_TEST_REPORTER_ID`
    - Value: `Test Coverage ID`
3. Add badge to readme file. [guide](https://docs.github.com/en/actions/managing-workflow-runs/adding-a-workflow-status-badge#using-the-event-parameter)
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

on: [push, pull_request]

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
      id: pipenv-cache
      with:
        path: ~/.local/share/virtualenvs
        key: ${{ runner.os }}-pipenv-cache-${{ hashFiles('Pipfile.lock') }}
        restore-keys: |
          ${{ runner.os }}-pipenv-cache

    - name: Installing requirements
      if: steps.pipenv-cache.outputs.cache-hit != 'true'
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

### Important Note
For the next commands, we will also assume that you are in the root folder, and you have already entered to the sell with `$ pipenv shell`

1. To create a new app into the project, we have to run the command `$ python manage.py startapp <new_app_name>`
    - **new_app_name**: is the name of the new app and it has to be written in plural. For example: targets
2. Since that command creates the new app at the root directory, you have to move it to `<project_name>` directory, where there are other existing apps like `users`.
    - **project_name**: is the name that you define in the first step of the project creation. For example: cookiecutter_starter
3. Other change is needed, you have to edit the `apps.py` file of the new app and replace the current `name` field of the config class from only `<new_app_name>` to `<project_name>.<new_app_name>`
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
