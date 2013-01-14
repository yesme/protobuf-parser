import java.io.IOException;
import org.antlr.runtime.*;
import org.antlr.runtime.tree.*;
import org.apache.commons.cli.*; 

public class ProtoCompiler {
  private static boolean showTrace;

private static void trace(Tree node, int depth) {
  for (int i=0; i<depth; ++i) {
    System.out.print("    ");
  }
  // System.out.print(node.getType());
  // System.out.print(" ");
  System.out.println(node.getText());
  for (int i=0; i<node.getChildCount(); ++i) {
    ProtoCompiler.trace(node.getChild(i), depth+1);
  }
}

private static void printHelp(Options options, String addition) {
  System.out.println(addition);
  HelpFormatter fmt = new HelpFormatter();
  fmt.printHelp("java -jar protoc.jar [options] proto_file1 proto_file2 ...", options);
  if (addition == "") {
    System.exit(0);
  } else {
    System.exit(1);
  }
}

private static void parseFile(String fname) {
  try {
    // create a CharStream that reads from a file
    ANTLRFileStream input = new ANTLRFileStream(fname);

    // create a lexer that feeds off of input CharStream
    ProtoLexer lex = new ProtoLexer(input);

    // create a buffer of tokens pulled from the lexer
    CommonTokenStream tokens = new CommonTokenStream(lex);

    // create a parser that feeds off the tokens buffer
    ProtoParser parser = new ProtoParser(tokens);

    // begin parsing at rule program
    ProtoParser.proto_return result = parser.proto();

    // generate the AST tree
    CommonTree tree = (CommonTree) result.getTree();

    // trace the tree
    if (ProtoCompiler.showTrace) {
      System.out.println("-------------------------------------------------------------------------------");
      ProtoCompiler.trace(tree, 0);
    }
/*
    StringBuilder msg = new StringBuilder();
    msg.append("Default AST tree: ");
    msg.append(tree.toStringTree());
    System.out.println(msg.toString());
*/
  } catch (RecognitionException e) {
    System.out.println("Protocol Buffer Parser threw exception:");
    e.printStackTrace();
  } catch (IOException e) {
    System.out.printf("File [%s] is not found. Skipped.", fname);
  }
}

public static void main(String[] args) throws Exception {
  // handle the options
  Options options = new Options();
  options.addOption("I", "proto_path", false, "Specify the directory in which to search for imports.");
  options.addOption("h", "help", false, "Show this text and exit.");
  options.addOption("t", "trace", false, "Show the traced tree.");

  CommandLineParser parser = new PosixParser();
  CommandLine cmd;

  try {
    cmd = parser.parse(options, args);

    // check "help" argument
    if (cmd.hasOption("h")) {
      ProtoCompiler.printHelp(options, "");
    }

    // check "trace" argument
    ProtoCompiler.showTrace = cmd.hasOption("t");

    // handle protobuf files
    String[] files = cmd.getArgs();
    if (files.length == 0) {
      ProtoCompiler.printHelp(options, "No protobuf file is specified.");
    }
    for (int i=0; i<files.length; ++i) {
      ProtoCompiler.parseFile(files[i]);
    }
    System.out.println("All files are successfully proceed.");
  } catch (ParseException e) {
    ProtoCompiler.printHelp(options, "Wrong arguments served to Protocol Buffer parser.");
  }
}

}
