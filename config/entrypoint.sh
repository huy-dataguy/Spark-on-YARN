#!/bin/bash

service ssh start

exec su spark-user bash -c "tail -F anything"