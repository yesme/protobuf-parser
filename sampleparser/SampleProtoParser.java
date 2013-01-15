package sampleparser;

import org.antlr.runtime.*;
import dsl.ProtoParser;

class SampleProtoParser extends ProtoParser {
  public SampleProtoParser(TokenStream input) {
    super(input, new RecognizerSharedState());
  }
  public SampleProtoParser(TokenStream input, RecognizerSharedState state) {
    super(input, state);     
  }
}
