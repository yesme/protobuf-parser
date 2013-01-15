Protobuf Parser
===============

Overview
--------

The goal of this project is to provide an open-sourced, easy-to-use Protocol Buffer parser for further usage.  Protocol Buffer is ["Google's data interchange format"](http://code.google.com/p/protobuf/), which is generously open-sourced.  It is widely used as the wire-format for RPC and structure data record.  For extended reading on this topic, please refer to its [documentation](https://developers.google.com/protocol-buffers/docs/overview).

The offical Protocol Buffer distribution generally includes 3 components:
- **Language-specific Message Compiler** Protocol Buffer is described in a [DSL (Domain Specific Language)](https://developers.google.com/protocol-buffers/docs/proto).  So compilers are provided to translate the DSL to native languages - C++, Java and Python are "officially" provided by Google and there are many "third-party" ones.
- **Language-specific Message Runtime** The compiler only translates the DSL into native language, so the runtime is provided to handle actual works such like encoding, decoding etc.  Again, C++, Java and Python are "officially supported".
- **Language-specific Service Compiler** _This is an deprecated feature provided by Google._  In the above DSL, customer may define the RPC service using <code>service</code> and <code>rpc</code> keywords.  However, since the service runtime is not provided, it may not be that helpful to use the generated service "stub" code in native language.

This project provides a fully-compatible Protocol Buffer parser based on [Antlr 3](http://antlr.org/).  It enables developers to:
- generate the message definition in native language, say Javascript, for a given proto file, and
- generate the service definition in native language.

This project is inspired by [sirikata's ProtoJs project](https://github.com/sirikata/protojs) which uses Antlr as well, but fully rewrote.

Install
-------

    git clone git://github.com/yesme/protobuf-parser.git
    cd protobuf-parser
    ./bootstrap.sh
    make

After that, a sample parser will be built.

How does it work
----------------

This project includes 3 components:
- <code>dsl</code>: Antlr grammar for Protocol Buffer
- <code>protos</code>: Sample Proto files basically covered most of the (normal and) corner cases defining a Protocol Buffer file
- <code>sampleparser</code>: A sample protobuf parser implementation

Therefore <code>make</code> will
1. build the DSL grammar into Java source code
2. build <code>sampleparser</code> against the generated DSL source code

For the one who wants to provide Protocol Buffer implementation, or provide Service implementation, please take a look at <code>sampleparser/SampleParser.java</code> - it's a sample shows how to use it.

In order to test the compatibility with protoc (Google's Protocol Buffer Compiler), run the following command:

    make testprotos

In order to test the current parser, run the following commands.  It will translate the input proto file into [AST (Abstract Syntax Tree)](http://en.wikipedia.org/wiki/Abstract_syntax_tree).

    make testparsersimple  # simply test if the parser works
    make testparserverbose # run the parser and print out the AST

For any question, please feel free to mail jacky.chao.wang@gmail.com for more information.
