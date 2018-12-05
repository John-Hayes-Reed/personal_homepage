migrate:
	docker-compose run web rails db:migrate

console:
	docker-compose run web rails console

routes:
	docker-compose run web rails routes

up:
	docker-compose up -d

build:
	docker-compose build

down:
	docker-compose down --remove-orphans
	rm -f tmp/pids/server.pid

logs:
	docker-compose logs -f

guard:
	docker-compose run --entrypoint 'bundle exec guard -g red_to_green --force-polling --clear' web

review:
	docker-compose run web rails spec
	docker-compose run web cucumber
	docker-compose run web rubocop

rubocop-a:
	docker-compose run web rubocop -a
