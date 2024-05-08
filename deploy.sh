#!/usr/bin/env bash
set -o errexit #abort if any command fails
# build futures-api/zh
docker run --rm --name slate -v $(pwd)/build/zh/latest/futures-api:/srv/slate/build -v $(pwd)/futures-api/zh/index.html.md:/srv/slate/source/index.html.md -v $(pwd)/futures-api/zh/includes:/srv/slate/source/includes futuresdocker/slate build
# build futures-api/en
#docker run --rm --name slate -v $(pwd)/build/en/latest/futures-api:/srv/slate/build -v $(pwd)/futures-api/en/index.html.md:/srv/slate/source/index.html.md -v $(pwd)/futures-api/en/includes:/srv/slate/source/includes futuresdocker/slate build

sudo cp $(pwd)/index.html $(pwd)/build

sudo cp $(pwd)/CNAME $(pwd)/build

#docker run --rm --name slate -p 4567:4567 -v $(pwd)/source:/srv/slate/source futures-open-api/slate serve


# git subtree push --prefix build origin gh-pages
