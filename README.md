Protobuf Compiler
=================

Overview
--------

The goal of this project is to provide an open-sourced, easy-to-use Protocol Buffer parser (and compiler) for further usage.  Protocol Buffer is ["Google's data interchange format"](http://code.google.com/p/protobuf/), which is generously open-sourced.  It is widely used as the wire-format for RPC and structure data record.  For extended reading on this topic, please refer to its [documentation](https://developers.google.com/protocol-buffers/docs/overview).

The offical Protocol Buffer distribution generally includes 3 components:
- **Language-specific Message Compiler** Protocol Buffer is described in a [DSL (Domain Specific Language)](https://developers.google.com/protocol-buffers/docs/proto).  So compilers are provided to translate the DSL to native languages - C++, Java and Python are "officially" provided by Google and there are many "third-party" ones.
- **Language-specific Message Runtime** The compiler only translates the DSL into native language, so the runtime is provided to handle actual works such like encoding, decoding etc.  Again, C++, Java and Python are "officially supported".
- **Language-specific Service Compiler** _This is an deprecated feature provided by Google._  In the above DSL, customer may define the RPC service using "service" and "rpc" keywords.  However, since the service runtime is not provided, it may not be that helpful to use the generated service "stub" code in native language.

This compiler provides a fully-compatible Protocol Buffer compiler based on [Antlr 3](http://antlr.org/).  It enables developers to:
- generate the message definition in native language, say Javascript, for a given proto file, and
- generate the service definition in native language.

This project is inspired by [sirikata's ProtoJs project](https://github.com/sirikata/protojs) which uses Antlr as well, but fully rewritten.

Install
-------

    git clone git://github.com/yesme/protobuf-compiler.git
    cd protobuf-compiler
    ./bootstrap.sh
    make

After that, a sample compiler will be build.
