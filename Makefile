PYTHON = python3
PROJECT_DIR = folder_hash

.DEFAULT_GOAL = help

.PHONY: help setup clean build upload install

help:
	@echo "---------------HELP-----------------"
	@echo "make help - display this message"
	@echo "make setup - setup the project for development"
	@echo "make clean - clean the project"
	@echo "make build - build the project"
	@echo "make upload - upload the project to PyPI"
	@echo "make install - install the project to local python installation"
	@echo "------------------------------------"

setup: clean
	@echo "Setting up project"
	${PYTHON} -m pip install -r requirements.txt
	${PYTHON} -m pip install -r ${PROJECT_DIR}/requirements.txt

clean:
	@echo "Cleaning project"
	rm --force --recursive *.pyc
	rm --force --recursive *.pyo
	rm --force --recursive build/
	rm --force --recursive dist/
	rm --force --recursive *.egg-info
	rm --force --recursive *.build/
	rm --force --recursive *.dist/

build: clean
	@echo "Building project"
	${PYTHON} setup.py sdist bdist_wheel

upload: clean
	@echo "Uploading project"
	${PYTHON} setup.py sdist bdist_wheel
	${PYTHON} -m twine upload dist/*

install: clean
	@echo "Installing project"
	${PYTHON} -m pip install .
