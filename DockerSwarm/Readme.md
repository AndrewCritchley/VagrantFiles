# Docker Swarm Environment

## Usage

1. vagrant up
2. varant ssh swarm_manager3
3. docker exec -it consul3 bash
4. consul members (should display all 3 manager nodes)
5. curl http://10.0.2.5:8500/v1/catalog/services | python -m json.tool (should display all services)
6. curl http://10.0.2.5:8500/v1/catalog/service/swarm | python -m json.tool