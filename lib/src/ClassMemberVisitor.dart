import 'package:analyzer_experimental/src/generated/ast.dart';
import 'package:analyzer_experimental/src/generated/java_core.dart';
import 'transformers.dart';
import 'jsast/js.dart' as js;

class ClassMemberVisitor implements ASTVisitor<Object> {
  ClassMemberVisitor();

  List<js.Statement> fields = new List<js.Statement>();
  String functionName;

  List<js.Parameter> consParams;
  js.Block consBlock = new js.Block.empty();

  List<js.Statement> get statements {
    var ret = new List<js.Statement>();

    // Create the constructor
    ret.add(new js.FunctionDeclaration(
        new js.VariableDeclaration(functionName),
        new js.Fun(consParams, consBlock),
        "@constructor"));
    ret.addAll(fields);
    return ret;
  }

  Object visitClassDeclaration(ClassDeclaration node) {
    functionName = node.name.toString();
    node.members.accept(this);
  }


  Object visitFieldDeclaration(FieldDeclaration node) {
    for (VariableDeclaration decl in node.fields.variables) {
       var name = decl.name.toString();


       fields.add(new js.ExpressionStatement(
          new js.VariableDeclaration.withType(
              "$functionName.prototype.$name", "string")));
    }
  }

  Object visitConstructorDeclaration(ConstructorDeclaration node) {
     consParams = new List<js.Parameter>();
     var consStatements = new List<js.Statement>();

     for(FormalParameter param in node.parameters.parameters) {
       String name = param.identifier.name;

      consStatements.add(new js.ExpressionStatement(
          new js.Assignment(
           new js.VariableDeclaration("this.$name"),
           new js.VariableUse(name))));
       consParams.add(new js.Parameter(name));
     }

     consBlock = new js.Block(consStatements);
  }

}