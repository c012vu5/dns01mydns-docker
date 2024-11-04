#!/bin/sh

if [ -e .env ]; then
    echo Initialize .env has already been completed.
else
    cp .env.template .env
    echo Initialize .env has been completed.
fi

echo You need to fill in the blanks.
