
curl -X 'POST' \
  'http://localhost:7200/api/TodoApi/CreateEditStatus' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "id": 1,
  "title": "Pending"
}'

curl -X 'POST' \
  'http://localhost:7200/api/TodoApi/CreateEditStatus' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "id": 2,
  "title": "In Progress"
}';

curl -X 'POST' \
  'http://localhost:7200/api/TodoApi/CreateEditStatus' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "id": 3,
  "title": "Done"
}';