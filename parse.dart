//part of dart2closure;

import 'dart:collection';

import 'package:analyzer_experimental/src/generated/java_core.dart';
import 'package:analyzer_experimental/src/generated/java_engine.dart';
import 'package:analyzer_experimental/src/generated/java_junit.dart';

import 'package:analyzer_experimental/src/generated/ast.dart';
import 'package:analyzer_experimental/src/generated/error.dart';
import 'package:analyzer_experimental/src/generated/parser.dart';
import 'package:analyzer_experimental/src/generated/scanner.dart';
import 'package:analyzer_experimental/src/generated/source.dart';

import 'listeners.dart';

CompilationUnit parseText(String text) {
  List<ErrorCode> errorCodes;
  ErrorListener errorListener = new ErrorListener();
  StringScanner scanner = new StringScanner(null, text, errorListener);
  Token token = scanner.tokenize();
  Parser parser = new Parser(null, errorListener);
  CompilationUnit unit = parser.parseCompilationUnit(token);
  // TODO(chirayu): When is "errorCodes" valid?
  return unit;
}


CompilationUnit parseFile(File file) {
  var text = file.readAsStringSync();
  return parseText(text);
}
