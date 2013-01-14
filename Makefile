ifeq ($(uname),Darwin)
FLAGS += -arch i386
endif

protoc.jar : ProtoCompiler.java ProtoParser.java ProtoLexer.java MANIFEST.MF
	@echo "building protoc.jar"
	@javac -classpath lib/antlr-runtime-3.2.jar:lib/commons-cli-1.2.jar:. ProtoCompiler.java ProtoParser.java ProtoLexer.java
	@jar -cfm protoc.jar MANIFEST.MF *.class
	@rm -f *.class

ProtoParser.java : ProtoParser.g ProtoLexer.tokens
	@echo "building parser"
	@java -jar lib/antlr-3.2.jar ProtoParser.g

ProtoParser.tokens : ProtoParser.g ProtoLexer.tokens
	@echo "building parser"
	@java -jar lib/antlr-3.2.jar ProtoParser.g

ProtoLexer.java : ProtoLexer.g
	@echo "building lexer"
	@java -jar lib/antlr-3.2.jar ProtoLexer.g

ProtoLexer.tokens : ProtoLexer.g
	@echo "building lexer"
	@java -jar lib/antlr-3.2.jar ProtoLexer.g

clean :
	@rm -f *.class Proto.tokens ProtoLexer.java ProtoParser.java *.tokens protoc.jar

#test : protoc.jar
#	@java -jar protoc.jar protos/main.proto
