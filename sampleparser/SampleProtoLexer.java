package sampleparser;

import org.antlr.runtime.*;
import dsl.ProtoLexer;

class SampleProtoLexer extends ProtoLexer {
  SampleExceptionHandler handler;

  public SampleProtoLexer() {}

  public SampleProtoLexer(CharStream input) {
    super(input, new RecognizerSharedState());
  }

  public SampleProtoLexer(CharStream input, RecognizerSharedState state) {
    super(input,state);
  }

  public void registerExceptionHandler(SampleExceptionHandler handler) {
  	this.handler = handler;
  }

  public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
  	handler.handle(tokenNames, e);
  }
}
