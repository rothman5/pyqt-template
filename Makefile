ENV ?= .venv
LOG ?= debug.log
TESTS ?= tests

ifeq ($(OS), Windows_NT)
    PYTHON := $(ENV)/Scripts/python.exe
	PYCLEAN := $(ENV)/Scripts/pyclean.exe
else
	PYTHON := $(ENV)/bin/python
	PYCLEAN := $(ENV)/bin/pyclean
endif

.PHONY: all clean clean_py clean_log

all: clean run

run:
	$(PYTHON) -m app

tests: test_controllers test_models test_utilities test_views

test_controllers:
	$(PYTHON) -m $(TESTS).test_controllers

test_models:
	$(PYTHON) -m $(TESTS).test_models

test_utilities:
	$(PYTHON) -m $(TESTS).test_utilities

test_views:
	$(PYTHON) -m $(TESTS).test_views

clean: clean_py clean_log

clean_py:
	$(PYCLEAN) .

clean_log:
	@if [ -f "$(LOG)" ]; then \
		rm -f $(LOG); \
		echo "Log file $(LOG) removed."; \
	else \
		echo "Log file $(LOG) does not exist."; \
	fi
