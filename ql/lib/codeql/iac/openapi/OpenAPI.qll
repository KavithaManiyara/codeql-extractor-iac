private import codeql.iac.YAML
private import codeql.files.FileSystem

predicate openapiFiles(Location loc) {
  loc.getFile().getBaseName() =
    [
      // Swagger JSON / YAML
      "swagger.yml", "swagger.yaml", "swagger.json",
      // OpenAPI JSON / YAML
      "openapi.json", "openapi.yml", "openapi.yaml",
    ]
}

private class Node extends YamlNode {
  Node() { openapiFiles(this.getLocation()) }
}

class OpenAPI extends Node, YamlDocument, YamlMapping {
  string getApiVersion() { result = this.lookup("apiVersion").toString() }

  string getVersion() { result = this.lookup("version").toString() }

  string getName() { result = this.lookup("name").toString() }

  string getType() { result = this.lookup("type").toString() }
}
