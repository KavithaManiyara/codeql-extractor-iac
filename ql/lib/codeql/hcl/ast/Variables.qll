private import codeql.Locations
private import codeql.files.FileSystem
private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.AstNodes

class Variable extends Expr, TVariable {
  HCL::VariableExpr var;

  Variable() { this = TVariable(var) }

  string getName() { result = var.getName().getValue() }
}

class GetAttrExpr extends Expr, TGetAttrExpr {
  HCL::GetAttrExpr getAttr;

  override string getAPrimaryQlClass() { result = "GetExpr" }

  GetAttrExpr() { this = TGetAttrExpr(getAttr) }

  Expr getExpr() { toHclTreeSitter(result) = getAttr.getExpr() }

  Identifier getKey() { toHclTreeSitter(result) = getAttr.getKey() }

  override string toString() { result = getExpr() + "." + getKey().getName() }

  override HclAstNode getAChild(string pred) {
    pred = "getExpr" and result = this.getExpr()
    or
    pred = "getKey" and result = this.getKey()
  }
}
