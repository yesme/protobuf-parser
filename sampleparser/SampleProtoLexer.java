package sampleparser;

import org.antlr.runtime.*;
import dsl.ProtoLexer;

class SampleProtoLexer extends ProtoLexer {
  public SampleProtoLexer() {;} 
  public SampleProtoLexer(CharStream input) {
    super(input, new RecognizerSharedState());
  }
  public SampleProtoLexer(CharStream input, RecognizerSharedState state) {
    super(input,state);

  }
}
