###############################################################################
#
# AC - Arquitectura de Computadores
# Grado en Ingeniería Informática
#
# 2015 - Román Arranz <raguerrero@correo.ugr.es>
# ---------------------------------------------
#
# Fichero Makefile para generacion de ejecutables, paquetes y documentacion
#
###############################################################################

# VARIABLES
SHELL = /bin/bash

BIN 	= bin
SRC 	= src
OBJ 	= obj
LIB 	= lib
DOC 	= doc
INCLUDE = include

OS := $(shell uname)
ifeq($(OS),Darwin)
CC  = gcc
CXX = 

# Coleccion de objetos a compilar
OBJECTS = 

# TODO (sin empaquetado)
all: clean $(OBJECTS)

# LIMPEZA
# Limpia los archivos compilados, así como los archivos objeto y los paquetes zip
clean:
	@echo "Limpiando..."
	@rm -f $(OBJ)/*\
        $(BIN)/*\
        $(DOC)/html/*\
        $(LIB)/*\
        ./*.tgz

.PHONY: all clean buildbegin