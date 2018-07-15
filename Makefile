CC			= gcc
CXX			= g++
OBJ			= objects.o nfsuserver2.o server.o ini.o INIReader.o
LIBS		= -L"/lib" -lpthread
INCS		= #-I "."

ifeq ($(CFG),debug)
	CXXFLAGS	= -g
	CFLAGS		= -g
	BIN			= nfsuserver_debug
else
	CXXFLAGS	= $(INCS) -s -O3 -fexpensive-optimizations --static
	CFLAGS		= -s -O3 --static
	BIN			= nfsuserver
endif

.PHONY: all all-before all-after clean clean-custom

all: all-before $(BIN) all-after

clean: clean-custom
	rm -f $(OBJ) $(BIN)

$(BIN): $(OBJ)
	$(CXX) $(OBJ) -o "$(BIN)" $(LIBS) $(CXXFLAGS)

nfsuserver2.o: nfsuserver2.cpp
	$(CXX) -c nfsuserver2.cpp -o nfsuserver2.o $(CXXFLAGS)

server.o: server.cpp
	$(CXX) -c server.cpp -o server.o $(CXXFLAGS)

objects.o: objects.cpp
	$(CXX) -c objects.cpp -o objects.o $(CXXFLAGS)

ini.o: ini.c
	$(CC) -c ini.c -o ini.o $(CFLAGS)

INIReader.o: INIReader.cpp
	$(CXX) -c INIReader.cpp -o INIReader.o $(CXXFLAGS)
