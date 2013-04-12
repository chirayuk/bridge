library visit_result;

// TODO(chirayu): Implement.
// class DartType {
//   final name;
//   const DartType([this.name = "<unknown>"]);
//   static const UNKNOWN = const DartType();
// 
//   toString() {
//     return "DartType($name)";
//   }
// }

import 'jsast/js.dart' as js;

class VisitResult {
  List nodes;
  var type;

  VisitResult([List<js.Node> nodes = null, this.type = null]) {
    this.nodes = (nodes == null) ? [] : nodes;
  }

  static fromJsNodeList(List<js.Node> nodes) {
    return new VisitResult(nodes);
  }

  static fromJsNode(js.Node node) {
    return new VisitResult([node]);
  }

  static fromTypedJsNode(js.Node node, typeName) {
    return new VisitResult([node], typeName);
  }

  static final EMPTY = new VisitResult();

  js.Node get node {
    switch(nodes.length) {
      case 0:
        return null;
      case 1:
        return nodes[0];
      default:
        throw "Attempt to get a single statement from a list: $nodes";
    }
  }

  dumpNodes() {
    return nodes.map((node) => js.prettyPrint(node).getText()).join(",\n").replaceAll("\n", "\n  ");
  }

  toString() {
    // return "VisitResult(type=$type, nodes=$nodes)";
    return "VisitResult(nodes=\n  ${dumpNodes()})";
  }
}

