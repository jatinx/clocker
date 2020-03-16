all:
	mkdir -p build
	nvcc test/add.cu -Iinclude -std=c++11 -o build/add
	./build/add

clean:
	rm -rf build
