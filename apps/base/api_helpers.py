from rest_framework.response import Response
from rest_framework import status


def response_401(message='No esta autorizado para realizar esta acción'):
    return Response(data={
        'status_code': 'HTTP_401_UNAUTHORIZED',
        'status': status.HTTP_401_UNAUTHORIZED,
        'message': message,
    }, status=status.HTTP_401_UNAUTHORIZED)
