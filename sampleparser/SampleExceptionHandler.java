package sampleparser;

import org.antlr.runtime.*;
import java.util.Map;

public class SampleExceptionHandler {
  private boolean isLexer;
  private String fname;
  private String[] tokenNames;
  private Map literalNames;

  public SampleExceptionHandler(String fname, Map literalNames, String[] tokenNames, boolean isLexer) {
    this.fname = fname;
    this.literalNames = literalNames;
    this.tokenNames = tokenNames;
    this.isLexer = isLexer;
  }

  private String handleMismatchedToken(MismatchedTokenException e) {
    if (isLexer) {
      return String.format("Unexpected input '%c'.", e.c);
    } else {
      if (e.expecting == Token.EOF) {
        return String.format("Unexpected input '%s' - 'package', 'import', 'option', 'enum', 'message', 'extend', 'server' is expected.", e.token.getText());
      }
      String expecting = tokenNames[e.expecting];
      if (literalNames.containsKey(expecting)) {
        expecting = (String) literalNames.get(expecting);
      }
      return String.format("Unexpected input '%s' - '%s' is expected.", e.token.getText(), expecting);
    }
  }

  private String handleNoViableAltException(NoViableAltException e) {
    if (isLexer) {
      return String.format("Unrecognized input '%c'.", e.c);
    } else {
      return String.format("Unrecognized input '%s'.", e.token.getText());
    }
  }

  private String handleMismatchedSetException(MismatchedSetException e) {
    if (isLexer) {
      return String.format("Unexpected input '%c'.", e.c);
    } else {
      return String.format("Unexpected input '%s'.", e.token.getText());
    }
  }

  public void handle(String[] tokenNames, RecognitionException e) {
    String errorMsg = "";
    if (e instanceof EarlyExitException) {
      errorMsg = "EarlyExitException";
    } else if (e instanceof FailedPredicateException) {
      errorMsg = "FailedPredicateException";
    } else if (e instanceof MismatchedRangeException) {
      errorMsg = "MismatchedRangeException";
    } else if (e instanceof MismatchedSetException) {
      errorMsg = this.handleMismatchedSetException((MismatchedSetException) e);
    } else if (e instanceof MismatchedTokenException) {
      errorMsg = this.handleMismatchedToken((MismatchedTokenException) e);
    } else if (e instanceof MismatchedTreeNodeException) {
      errorMsg = "MismatchedTreeNodeException";
    } else if (e instanceof NoViableAltException) {
      errorMsg = this.handleNoViableAltException((NoViableAltException) e);
    }
    System.out.printf("[%s] Line %d: %s\n", this.fname, e.line, errorMsg);
    System.exit(1);
  }
}
