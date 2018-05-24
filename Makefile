CWD := $(shell pwd)

.PHONY: all
all: clean

.PHONY: start
start: env
	@env/bin/python3 example

.PHONY: debug
debug: env
	@env/bin/python3 example --debug

.PHONY: install
install: env

.PHONY: uninstall
uninstall:
	-@rm -rf env >/dev/null || true

.PHONY: reinstall
reinstall: uninstall install

env:
	@virtualenv env
	@env/bin/pip3 install -r requirements.txt
	@echo ::: ENV :::

.PHONY: freeze
freeze:
	@env/bin/pip3 freeze > requirements.txt
	@echo ::: FREEZE :::

dist: env
	@python setup.py sdist
	@python setup.py bdist_wheel
	@echo ran dist

.PHONY: publish
publish: dist
	@twine upload dist/*
	@echo published

.PHONY: clean
clean:
	-@rm -rf */__pycache__ */*/__pycache__ README.rst >/dev/null || true
	@echo ::: CLEAN :::
