ifeq ($(uname),Darwin)
FLAGS += -arch i386
endif

sampleparser.jar : dsl/ProtoParser.java dsl/ProtoLexer.java sampleparser/MANIFEST.MF sampleparser/*.java
	@echo "building sampleparser.jar"
	@javac -classpath lib/antlr-runtime-3.2.jar:lib/commons-cli-1.2.jar:lib/guava-13.0.1.jar:. dsl/*.java sampleparser/*.java
	@jar -cfm sampleparser.jar sampleparser/MANIFEST.MF dsl/*.class sampleparser/*.class
	@rm -f *.class

dsl/ProtoParser.java : dsl/ProtoParser.g dsl/ProtoLexer.tokens
	@echo "building parser"
	@java -jar lib/antlr-3.2.jar -fo dsl/ dsl/ProtoParser.g

dsl/ProtoParser.tokens : dsl/ProtoParser.g dsl/ProtoLexer.tokens
	@echo "building parser"
	@java -jar lib/antlr-3.2.jar -fo dsl/ dsl/ProtoParser.g

dsl/ProtoLexer.java : dsl/ProtoLexer.g
	@echo "building lexer"
	@java -jar lib/antlr-3.2.jar -fo dsl/ dsl/ProtoLexer.g

dsl/ProtoLexer.tokens : dsl/ProtoLexer.g
	@echo "building lexer"
	@java -jar lib/antlr-3.2.jar -fo dsl/ dsl/ProtoLexer.g

clean :
	@rm -f dsl/*.java dsl/*.tokens dsl/*.class sampleparser/*.class sampleparser.jar

cleanclean : clean
	@rm -rf lib

testparsersimple : sampleparser.jar
	@java -jar sampleparser.jar protos/*.proto

testparserverbose : sampleparser.jar
	@java -jar sampleparser.jar protos/*.proto -t

testprotos :
	@if [ -d output ]; then true; else mkdir output; fi
	@protoc --proto_path=/usr/local/include:protos/:. --java_out=./output/ --cpp_out=./output/ --python_out=./output/ protos/*.proto
	@rm -rf ./output
