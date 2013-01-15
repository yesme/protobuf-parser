#!/bin/sh
if [ -d lib ]; then
	true
else
	mkdir lib
fi

if [ -e lib/antlr-3.2.jar ]; then
	true
else
	echo "Downloading ANTLR 3.2 JAR from http://www.antlr.org/download.html"
	curl http://www.antlr.org/download/antlr-3.2.jar > lib/antlr-3.2.jar || \
	(echo "Failed to download ANTLR. Aborting.";rm -f lib/antlr-3.2.jar;exit 1)
fi

if [ -e lib/antlr-runtime-3.2.jar ]; then
	true
else
	echo "Downloading ANTLR 3.2 JAR from http://www.antlr.org/download.html"
	curl http://www.antlr.org/download/antlr-runtime-3.2.jar > lib/antlr-runtime-3.2.jar || \
	(echo "Failed to download ANTLR Runtime. Aborting.";rm -f lib/antlr-runtime-3.2.jar;exit 1)
fi

if [ -e lib/commons-cli-1.2.jar ]; then
	true
else
	echo "Downloading Apache Common Cli JAR from http://commons.apache.org/cli/download_cli.cgi"
	curl http://www.us.apache.org/dist//commons/cli/binaries/commons-cli-1.2-bin.tar.gz | tar -zxf - commons-cli-1.2/commons-cli-1.2.jar -O > lib/commons-cli-1.2.jar || \
	(echo "Failed to download ANTLR. Aborting.";rm -f lib/commons-cli-1.2.jar;exit 1)
fi

echo "Type 'make' to compile Protocol Buffer Parser."
