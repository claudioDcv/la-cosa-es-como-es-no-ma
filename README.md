# la-cosa-es-como-es-no-ma
la-cosa-es-como-es-no-ma

- export data
```bash
./manage.py dumpdata --exclude auth.permission --exclude contenttypes > db.json
```

- program/arq/2/course/1/evaluated/2: `programa/<program_slug>/<profile_id>/course/<course_id>/evaluated/<user_id>`

- Cursos
    - String del curso: 1400S-AAC111-2018_1-1
    - String explicado: Programa-Asignatura-Periodo-Sección


# Problemas
- averiguar si seccion debe ser algo mas que un string en Course

- esta bien el indicador vinculado a la carrera?


./manage.py loaddata testadata.json
./manage.py load_student_to_system
./manage.py load_students_to_courses

initial_data
    load_student_to_system
    load_students_to_courses


Course

unique
    code-section-sede-period

Buscar y reemplazar
- 'matricula':'([0-9a-z-A-Z]+)', 'comentario':''}"

- recordar que los estudiantes se deberian asignar por rut no por codigo interno
- se agrego code para usuarios para codigos internos



# ERRORES
- Cursos que no existen
    - ARDCP11
    - ARDCP12