import os
import sys
import dj_database_url

IS_DEBUG = False
if len(sys.argv) > 1:
    IS_DEBUG = (sys.argv[1] == 'runserver')


# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


PROJECT_DIR = BASE_DIR

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.10/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'pwh@p6fuw1$)-w!d6nare@@e9)e(pyalz_5%z@ltbnq)dz-)ou'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = IS_DEBUG

ALLOWED_HOSTS = ['*']


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'rest_framework',

    'whitenoise.runserver_nostatic',

    'apps.base',
    'apps.business',
    'apps.core',
    'apps.log',
    'apps.term',
    'apps.topology',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
]

ROOT_URLCONF = 'conf.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'conf.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
#     }
# }






DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'skills_evaluation',
        'USER': 'postgres',
        'PASSWORD': '1234567890',
        'HOST': '127.0.0.1',
        'PORT': '5432',
    }
}
# if IS_DEBUG:
#     DATABASES = {
#         'default': {
#             'ENGINE': 'django.db.backends.postgresql_psycopg2',
#             'NAME': 'skills_evaluation',
#             'USER': 'postgres',
#             'PASSWORD': '1234567890',
#             'HOST': '127.0.0.1',
#             'PORT': '5432',
#         }
#     }
# else:
#     DATABASES = {}
#     DATABASES['default'] = dj_database_url.config()
#     DATABASES['default']['CONN_MAX_AGE'] = 500







# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql_psycopg2',
#         'NAME': os.environ.get('DB_NAME', 'skills_evaluation'),
#         'USER': os.environ.get('DB_USER', 'postgres'),
#         'PASSWORD': os.environ.get('DB_PASS', '1234567890'),
#         'HOST': os.environ.get('DB_HOST', '127.0.0.1'),
#         'PORT': os.environ.get('DB_PORT', '5432'),
#     }
# }


# Password validation
# https://docs.djangoproject.com/en/1.10/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': (
        'rest_framework.permissions.IsAuthenticated',
    )
}

# Internationalization
# https://docs.djangoproject.com/en/1.10/topics/i18n/

LANGUAGE_CODE = 'es-cl'

TIME_ZONE = 'America/Santiago'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.10/howto/static-files/

# STATIC_URL = '/static/'
# STATIC_ROOT = os.path.join(BASE_DIR, 'static/')

AUTH_USER_MODEL = 'base.User'


LOGOUT_REDIRECT_URL = '/'
LOGIN_REDIRECT_URL = 'home'

# Simplified static file serving.
# https://warehouse.python.org/project/whitenoise/

STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.9/howto/static-files/
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATIC_URL = '/static/'

STATIC_URL = '/static/'

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, "static"),
]

MEDIA_URL = '/media/'

MEDIA_ROOT = '{}{}'.format(PROJECT_DIR, '/media')
