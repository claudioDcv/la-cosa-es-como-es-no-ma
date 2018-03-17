import csv
import json

# python ./student.py > student.json
# ATTR
# n,promocion,matricula,id,nombre,paterno,materno,email


def csv_dict_reader():
    """Read a CSV file using csv.DictReader."""
    with open("imports_csv/student.csv") as file_obj:
        clean_list = []
        reader = csv.DictReader(file_obj, delimiter=',')
        for line in reader:
            if line.get('email') and line.get('username'):
                line['password'] = line['username'] + line['email']
                line['model'] = 'base.user'
                clean_list.append(line)

    # print(clean_list)
    # print(len(clean_list))
    return json.dumps(clean_list)
