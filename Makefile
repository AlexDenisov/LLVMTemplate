include ./LLVMTemplate/LLVM.xcconfig

LLVM_REMOTE_URL=http://llvm.org/git/llvm.git
LLVM_LIBS=$(shell echo $(LLVM_LINKER_FLAGS) | sed "s/-l//g")

SAMPLE_DIR=Sample
SAMPLE_SOURCES=math.c fib.c find_max.c

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

build_sample:
	cd $(SAMPLE_DIR) && \
    clang -S -emit-llvm $(SAMPLE_SOURCES)
	cd $(SAMPLE_DIR) && \
    clang -c -emit-llvm $(SAMPLE_SOURCES)

build: build_sample
	cd $(LLVM_BUILD_DIR) && \
		make $(LLVM_LIBS) -j `sysctl -n hw.ncpu`

all:
	echo $(LLVM_BUILD_DIR)

