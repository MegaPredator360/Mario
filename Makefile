# Mario Game Makefile
# C++ clone of Super Mario Bros by MitchellSternke

# Compiler and flags
CXX = g++
CXXFLAGS = -std=c++11 -Wall -Wextra -g -O1 -fno-omit-frame-pointer

# Directories
SRCDIR = .
OBJDIR = obj
BINDIR = bin
RESDIR = resources

# Include directories
INCLUDES = -I$(SRCDIR) \
           -I/usr/include \
           -I/usr/local/include \
           -I/usr/include/SDL2 \
           -I/usr/include/IL \
           -I/usr/include/boost

# Libraries to link
LIBS = -lSDL2 \
       -lSDL2_mixer \
       -lGL \
       -lIL \
       -lILU \
       -lILUT \
       -lboost_system \
       -lboost_filesystem \
       $(shell pkg-config --libs glu 2>/dev/null || echo "")

# Find all .cpp files in current directory and subdirectories
SOURCES = $(shell find $(SRCDIR) -name "*.cpp" -not -path "*/$(OBJDIR)/*" -not -path "*/$(BINDIR)/*")

# Generate object file names
OBJECTS = $(SOURCES:%.cpp=$(OBJDIR)/%.o)

# Target executable
TARGET = $(BINDIR)/mario

# Default target
all: $(TARGET)

# Create target executable
$(TARGET): $(OBJECTS) | $(BINDIR)
	@echo "Linking $(TARGET)..."
	$(CXX) $(OBJECTS) -o $@ $(LIBS)
	@echo "Creating default settings.ini in bin directory..."
	@if [ ! -f $(BINDIR)/settings.ini ]; then \
		echo "# Mario Engine Settings" > $(BINDIR)/settings.ini; \
		echo "# Video" >> $(BINDIR)/settings.ini; \
		echo "screenWidth=1280" >> $(BINDIR)/settings.ini; \
		echo "screenHeight=720" >> $(BINDIR)/settings.ini; \
		echo "fullscreen=0" >> $(BINDIR)/settings.ini; \
		echo "" >> $(BINDIR)/settings.ini; \
		echo "# Audio" >> $(BINDIR)/settings.ini; \
		echo "music=1" >> $(BINDIR)/settings.ini; \
		echo "sound=1" >> $(BINDIR)/settings.ini; \
		echo "" >> $(BINDIR)/settings.ini; \
		echo "# Misc" >> $(BINDIR)/settings.ini; \
		echo "debugMode=0" >> $(BINDIR)/settings.ini; \
		echo "Default settings.ini created in bin directory"; \
	fi
	@echo "Build complete!"

# Compile source files to object files
$(OBJDIR)/%.o: %.cpp | $(OBJDIR)
	@echo "Compiling $<..."
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

# Create directories if they don't exist
$(OBJDIR):
	mkdir -p $(OBJDIR)

$(BINDIR):
	mkdir -p $(BINDIR)

# Install dependencies (Debian/Ubuntu)
install-deps:
	@echo "Installing dependencies..."
	sudo apt update
	sudo apt install -y \
		libsdl2-dev \
		libsdl2-mixer-dev \
		libgl1-mesa-dev \
		libglu1-mesa-dev \
		libdevil-dev \
		libboost-all-dev \
		librapidxml-dev \
		build-essential

# Generate default settings.ini
generate-settings:
	@echo "Generating settings.ini in bin directory..."
	@mkdir -p $(BINDIR)
	@echo "# Mario Engine Settings" > $(BINDIR)/settings.ini;
	@echo "# Video" >> $(BINDIR)/settings.ini;
	@echo "screenWidth=1280" >> $(BINDIR)/settings.ini;
	@echo "screenHeight=720" >> $(BINDIR)/settings.ini;
	@echo "fullscreen=0" >> $(BINDIR)/settings.ini;
	@echo "" >> $(BINDIR)/settings.ini;
	@echo "# Audio" >> $(BINDIR)/settings.ini;
	@echo "music=1" >> $(BINDIR)/settings.ini;
	@echo "sound=1" >> $(BINDIR)/settings.ini;
	@echo "" >> $(BINDIR)/settings.ini;
	@echo "# Misc" >> $(BINDIR)/settings.ini;
	@echo "debugMode=0" >> $(BINDIR)/settings.ini;
	@echo "Settings.ini generated successfully!"

# Setup resources directory
setup-resources:
	@echo "Setting up resources directory..."
	mkdir -p $(RESDIR)
	@echo "Please download resources from: http://bit.ly/1myJJk0"
	@echo "And extract them to the $(RESDIR) directory"

# Copy resources to bin/resources directory
copy-resources: | $(BINDIR)
	@if [ -d "$(RESDIR)" ]; then \
		echo "Copying resources from $(RESDIR) to $(BINDIR)/$(RESDIR)/..."; \
		mkdir -p $(BINDIR)/$(RESDIR); \
		cp -r $(RESDIR)/* $(BINDIR)/$(RESDIR)/; \
		echo "Resources copied successfully to $(BINDIR)/$(RESDIR)/!"; \
	else \
		echo "Warning: $(RESDIR) directory not found. Skipping resource copy."; \
		echo "Run 'make setup-resources' to create resources directory."; \
	fi

# Setup complete game environment
setup-game: $(TARGET) generate-settings
	@echo "Game setup complete!"
	@echo "You can now run: make run"

# Clean build files
clean:
	@echo "Cleaning build files..."
	rm -rf $(OBJDIR) $(BINDIR)

# Clean everything including resources
clean-all: clean
	rm -rf $(RESDIR)

# Run the game
run: $(TARGET)
	@echo "Running Mario..."
	cd $(dir $(TARGET)) && ./$(notdir $(TARGET))

# Run with debugger
debug-run: debug
	@echo "Running Mario with GDB..."
	cd $(dir $(TARGET)) && gdb -ex run ./$(notdir $(TARGET))

# Check resources before running
check-resources:
	@echo "Checking resources..."
	@if [ ! -d "$(RESDIR)" ]; then \
		echo "❌ Resources directory missing!"; \
		echo "Run: make setup-resources"; \
		exit 1; \
	fi
	@if [ ! -f "$(RESDIR)/resources.xml" ]; then \
		echo "❌ resources.xml missing!"; \
		echo "Please download resources from the Dropbox link"; \
		exit 1; \
	fi
	@echo "✅ Resources directory found"
	@echo "✅ resources.xml found"

# Run with backtrace on crash
run-bt: $(TARGET)
	@echo "Running Mario with backtrace on crash..."
	cd $(dir $(TARGET)) && gdb -batch -ex run -ex bt -ex quit ./$(notdir $(TARGET))

# Safe run with resource checking
safe-run: $(TARGET) check-resources
	@echo "Running Mario (with resource check)..."
	cd $(dir $(TARGET)) && ./$(notdir $(TARGET))

# Debug build
debug: CXXFLAGS += -DDEBUG -g3 -O0
debug: $(TARGET)

# Release build
release: CXXFLAGS += -DNDEBUG -O3
release: clean $(TARGET)

# Check if all dependencies are installed
check-deps:
	@echo "Checking dependencies..."
	@pkg-config --exists sdl2 && echo "✓ SDL2 found" || echo "✗ SDL2 missing"
	@pkg-config --exists SDL2_mixer && echo "✓ SDL2_mixer found" || echo "✗ SDL2_mixer missing"
	@pkg-config --exists gl && echo "✓ OpenGL found" || echo "✗ OpenGL missing"
	@pkg-config --exists IL && echo "✓ DevIL found" || echo "✗ DevIL missing (install libdevil-dev)"
	@ldconfig -p | grep -q boost && echo "✓ Boost found" || echo "✗ Boost missing"
	@find /usr -name "rapidxml.hpp" 2>/dev/null | head -1 | xargs -I {} echo "✓ RapidXML found at {}" || echo "✗ RapidXML missing"

# Show help
help:
	@echo "Mario Game Makefile"
	@echo "==================="
	@echo "Available targets:"
	@echo "  all          		- Build the game (default)"
	@echo "  clean        		- Remove build files"
	@echo "  clean-all    		- Remove build files and resources"
	@echo "  run             	- Build and run the game"
	@echo "  debug-run        	- Run game with GDB debugger"
	@echo "  run-bt           	- Run game with backtrace on crash"
	@echo "  safe-run         	- Run game with resource verification"
	@echo "  check-resources  	- Verify resources are properly installed"
	@echo "  copy-resources      - Copy resources to bin directory"
	@echo "  debug        		- Build debug version"
	@echo "  release      		- Build optimized release version"
	@echo "  install-deps 		- Install required dependencies"
	@echo "  setup-resources 	- Create resources directory"
	@echo "  generate-settings 	- Create default settings.ini in bin directory"
	@echo "  setup-game       	- Build game and generate settings"
	@echo "  check-deps   		- Check if dependencies are installed"
	@echo "  help         		- Show this help message"

.PHONY: all clean clean-all run debug release install-deps setup-resources check-deps help generate-settings setup-game debug-run run-bt safe-run check-resources