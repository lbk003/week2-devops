clean:
	if [ $$(docker ps -a -q| grep container | wc -l) -gt 0 ]; then \
		docker stop $$(docker ps -a -q); \
		docker rm $$(docker ps -a -q); \
	fi

build:
	docker build -t quote-gen-service ./quote_gen
	docker build -t quote-disp-service ./quote_disp

run:
	docker rm -f quote-gen-container quote-disp-container
	docker run -d --name quote-gen-container --network quote-network -p 5000:5000 quote-gen-service
	docker run -d --name quote-disp-container --network quote-network -p 5001:5001 quote-disp-service

rebuild:
	make clean
	make build
	make run

restart:
	make clean
	make run