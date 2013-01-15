package sampleparser;

import org.antlr.runtime.*;
import dsl.ProtoParser;

class SampleProtoParser extends ProtoParser {
  SampleExceptionHandler handler;

  public SampleProtoParser(TokenStream input) {
    super(input, new RecognizerSharedState());
  }

  public SampleProtoParser(TokenStream input, RecognizerSharedState state) {
    super(input, state);     
  }

  public void registerExceptionHandler(SampleExceptionHandler handler) {
  	this.handler = handler;
  }

  public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
  	handler.handle(tokenNames, e);
  }
}
