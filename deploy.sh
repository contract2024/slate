#!/usr/bin/env bash
set -o errexit #abort if any command fails
# build futures-api/zh
docker run --rm --name slate1 -v $(pwd)/build/zh/latest/futures-open-api:/srv/slate/build -v $(pwd)/futures-open-api/zh/index.html.md.erb:/srv/slate/source/index.html.md.erb -v $(pwd)/futures-open-api/zh/includes:/srv/slate/source/includes futuresdocker/slate build
# build futures-api/en
docker run --rm --name slate1 -v $(pwd)/build/en/latest/futures-open-api:/srv/slate/build -v $(pwd)/futures-open-api/en/index.html.md.erb:/srv/slate/source/index.html.md.erb -v $(pwd)/futures-open-api/en/includes:/srv/slate/source/includes futuresdocker/slate build

docker run --rm --name slate1 -v $(pwd)/build/zh/latest/futures-broker-api:/srv/slate/build -v $(pwd)/futures-broker-api/zh/index.html.md.erb:/srv/slate/source/index.html.md.erb -v $(pwd)/futures-broker-api/zh/includes:/srv/slate/source/includes futuresdocker/slate build

docker run --rm --name slate1 -v $(pwd)/build/en/latest/futures-broker-api:/srv/slate/build -v $(pwd)/futures-broker-api/en/index.html.md.erb:/srv/slate/source/index.html.md.erb -v $(pwd)/futures-broker-api/en/includes:/srv/slate/source/includes futuresdocker/slate build


#sudo cp $(pwd)/CNAME $(pwd)/build

#docker run --rm --name slate1 -p 4567:4567 -v $(pwd)/source:/srv/slate/source futuresdocker/slate serve


# git subtree push --prefix build origin gh-pages


