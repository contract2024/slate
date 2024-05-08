#!/usr/bin/env bash
set -o errexit #abort if any command fails
# build futures-api/zh
docker run --rm --name slate1 -v $(pwd)/build/zh/latest/API-MPC:/srv/slate/build -v $(pwd)/futures-open-api/zh/index.html.md.erb:/srv/slate/source/index.html.md.erb -v $(pwd)/futures-open-api/zh/includes:/srv/slate/source/includes futuresdocker/slate build
# build futures-api/en
#docker run --rm --name slate -v $(pwd)/build/en/latest/futures-api:/srv/slate/build -v $(pwd)/futures-api/en/_index.md.erb.erb:/srv/slate/source/_index.md.erb.erb -v $(pwd)/futures-api/en/includes:/srv/slate/source/includes futuresdocker/slate build


#sudo cp $(pwd)/CNAME $(pwd)/build

#docker run --rm --name slate -p 4567:4567 -v $(pwd)/source:/srv/slate/source futures-open-api/slate serve


# git subtree push --prefix build origin gh-pages


