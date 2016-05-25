include ./LLVMTemplate/LLVM.xcconfig

LLVM_REMOTE_URL=http://llvm.org/git/llvm.git
LLVM_LIBS=$(shell echo $(LLVM_LINKER_FLAGS) | sed "s/-l//g")

setup:
	mkdir -p $(LLVM_SOURCE_DIR)
	mkdir -p $(LLVM_BUILD_DIR)
	
	cd $(LLVM_SOURCE_DIR) && \
		git init . && \
		git remote add origin $(LLVM_REMOTE_URL) && \
		git pull origin master
	
	cd $(LLVM_BUILD_DIR) && \
		cmake $(LLVM_SOURCE_DIR)

update:
	cd $(LLVM_SOURCE_DIR) && \
		git pull origin master

build:
	cd $(LLVM_BUILD_DIR) && \
		make $(LLVM_LIBS) -j `sysctl -n hw.ncpu`

all:
	echo $(LLVM_BUILD_DIR)

