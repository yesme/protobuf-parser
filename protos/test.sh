protoc --proto_path=/usr/local/include:. --java_out=./output/ --cpp_out=./output/ --python_out=./output/ main.proto
rm -rf ./output/*
