{
  "$graph": [
    {
      "class": "CommandLineTool",
      "id": "makerdfs",
      "inputs": [
        {
          "id": "schema",
          "type": "File"
        },
        {
          "id": "target_path",
          "type": "string"
        }
      ],
      "outputs": [
        {
          "id": "rdfs",
          "outputBinding": {
            "glob": "$(inputs.target_path)"
          },
          "type": "File"
        },
        {
          "id": "targetdir",
          "outputBinding": {
            "outputEval": "$(inputs.target_path.match(/^([^/]+)\\/[^/]/)[1])"
          },
          "type": "string"
        }
      ],
      "requirements": {
        "InlineJavascriptRequirement": {}
      },
      "arguments": [
        "python",
        "-mschema_salad",
        "--print-rdfs",
        "$(inputs.schema)"
      ],
      "stdout": "$(inputs.target_path)"
    },
    {
      "class": "CommandLineTool",
      "id": "makecontext",
      "inputs": [
        {
          "id": "schema",
          "type": "File"
        },
        {
          "id": "target_path",
          "type": "string"
        }
      ],
      "outputs": [
        {
          "id": "jsonld_context",
          "outputBinding": {
            "glob": "$(inputs.target_path)"
          },
          "type": "File"
        },
        {
          "id": "targetdir",
          "outputBinding": {
            "outputEval": "$(inputs.target_path.match(/^([^/]+)\\/[^/]/)[1])"
          },
          "type": "string"
        }
      ],
      "requirements": {
        "InlineJavascriptRequirement": {}
      },
      "arguments": [
        "python",
        "-mschema_salad",
        "--print-jsonld-context",
        "$(inputs.schema)"
      ],
      "stdout": "$(inputs.target_path)"
    },
    {
      "class": "CommandLineTool",
      "id": "inheritance",
      "inputs": [
        {
          "id": "schema",
          "type": "File"
        },
        {
          "id": "target_path",
          "type": "string"
        }
      ],
      "outputs": [
        {
          "id": "svg",
          "outputBinding": {
            "glob": "$(inputs.target_path)"
          },
          "type": "File"
        },
        {
          "id": "targetdir",
          "outputBinding": {
            "outputEval": "$(inputs.target_path.match(/^([^/]+)\\/[^/]/)[1])"
          },
          "type": "string"
        }
      ],
      "requirements": {
        "InlineJavascriptRequirement": {},
        "InitialWorkDirRequirement": {
          "listing": [
            {
              "entryname": "_script",
              "entry": "  schema-salad-tool --print-inheritance-dot \"$(inputs.schema.path)\" | dot -Tsvg\n"
            }
          ]
        }
      },
      "arguments": [
        "sh",
        "_script"
      ],
      "stdout": "$(inputs.target_path)"
    },
    {
      "class": "CommandLineTool",
      "id": "makedoc",
      "inputs": [
        {
          "id": "source",
          "type": "File"
        },
        {
          "id": "renderlist",
          "type": [
            "null",
            {
              "type": "array",
              "items": "string"
            }
          ],
          "inputBinding": {
            "position": 1,
            "prefix": "--only"
          }
        },
        {
          "id": "redirect",
          "type": [
            "null",
            {
              "type": "array",
              "items": "string",
              "inputBinding": {
                "prefix": "--redirect"
              }
            }
          ],
          "inputBinding": {
            "position": 2
          }
        },
        {
          "id": "brand",
          "type": "string",
          "inputBinding": {
            "position": 3,
            "prefix": "--brand"
          }
        },
        {
          "id": "brandlink",
          "type": "string",
          "inputBinding": {
            "position": 4,
            "prefix": "--brandlink"
          }
        },
        {
          "id": "target",
          "type": "string"
        },
        {
          "id": "primtype",
          "type": [
            "null",
            "string"
          ],
          "inputBinding": {
            "position": 5,
            "prefix": "--primtype"
          }
        },
        {
          "id": "extra",
          "type": "File"
        }
      ],
      "outputs": [
        {
          "id": "html",
          "outputBinding": {
            "glob": "$(inputs.target)"
          },
          "type": "File"
        },
        {
          "id": "targetdir",
          "outputBinding": {
            "outputEval": "${\n    var m = inputs.target.match(/^([^/]+)\\/[^/]/);\n    if (m)\n       return m[1];\n    else\n       return \"\";\n  }"
          },
          "type": "string"
        },
        {
          "id": "extra_out",
          "outputBinding": {
            "outputEval": "$(inputs.extra)"
          },
          "type": "File"
        }
      ],
      "requirements": {
        "InlineJavascriptRequirement": {}
      },
      "arguments": [
        "schema-salad-doc",
        "$(inputs.source)"
      ],
      "stdout": "$(inputs.target)"
    },
    {
      "class": "Workflow",
      "id": "main",
      "requirements": {
        "ScatterFeatureRequirement": {},
        "StepInputExpressionRequirement": {}
      },
      "inputs": [
        {
          "id": "render",
          "type": {
            "type": "array",
            "items": {
              "type": "record",
              "fields": [
                {
                  "name": "source",
                  "type": "File"
                },
                {
                  "name": "renderlist",
                  "type": [
                    "null",
                    {
                      "type": "array",
                      "items": "string"
                    }
                  ]
                },
                {
                  "name": "redirect",
                  "type": [
                    "null",
                    {
                      "type": "array",
                      "items": "string"
                    }
                  ]
                },
                {
                  "name": "target",
                  "type": "string"
                },
                {
                  "name": "brandlink",
                  "type": "string"
                },
                {
                  "name": "brandimg",
                  "type": "string"
                },
                {
                  "name": "primtype",
                  "type": [
                    "null",
                    "string"
                  ]
                },
                {
                  "name": "extra",
                  "type": "File"
                }
              ]
            }
          }
        },
        {
          "id": "schemas",
          "type": {
            "type": "array",
            "items": {
              "type": "record",
              "fields": [
                {
                  "name": "schema_in",
                  "type": "File"
                },
                {
                  "name": "context_target",
                  "type": "string"
                },
                {
                  "name": "rdfs_target",
                  "type": "string"
                },
                {
                  "name": "graph_target",
                  "type": "string"
                }
              ]
            }
          }
        },
        {
          "id": "brandimg",
          "type": "File"
        }
      ],
      "outputs": [
        {
          "id": "rdfs",
          "type": {
            "type": "array",
            "items": "File"
          },
          "outputSource": "makerdfs/rdfs"
        },
        {
          "id": "targetdir",
          "type": {
            "type": "array",
            "items": "string"
          },
          "outputSource": "makedoc/targetdir"
        }
      ],
      "steps": [
        {
          "in": {
            "schema": {
              "valueFrom": "$(inputs.schema.schema_in)",
              "source": "schemas"
            },
            "target_path": {
              "valueFrom": "$(inputs.schema.rdfs_target)"
            }
          },
          "out": [
            "rdfs",
            "targetdir"
          ],
          "id": "makerdfs",
          "run": "#makerdfs",
          "scatter": [
            "schema"
          ]
        },
        {
          "in": {
            "schema": {
              "valueFrom": "$(inputs.schema.schema_in)",
              "source": "schemas"
            },
            "target_path": {
              "valueFrom": "$(inputs.schema.rdfs_target)"
            }
          },
          "out": [
            "jsonld_context",
            "targetdir"
          ],
          "id": "makecontext",
          "run": "#makecontext",
          "scatter": [
            "schema"
          ]
        },
        {
          "in": {
            "schema": {
              "valueFrom": "$(inputs.schema.schema_in)",
              "source": "schemas"
            },
            "target_path": {
              "valueFrom": "$(inputs.schema.rdfs_target)"
            }
          },
          "out": [
            "svg",
            "targetdir"
          ],
          "id": "inheritance",
          "run": "#inheritance",
          "scatter": [
            "schema"
          ]
        },
        {
          "in": {
            "source": {
              "valueFrom": "$(inputs.rdr.source)"
            },
            "target": {
              "valueFrom": "$(inputs.rdr.target)"
            },
            "rdrlist": {
              "valueFrom": "$(inputs.rdr.renderlist)"
            },
            "redirect": {
              "valueFrom": "$(inputs.rdr.redirect)"
            },
            "brandlink": {
              "valueFrom": "$(inputs.rdr.brandlink)"
            },
            "brand": {
              "valueFrom": "$(inputs.rdr.brandimg)"
            },
            "primtype": {
              "valueFrom": "$(inputs.rdr.primtype)"
            },
            "extra": {
              "valueFrom": "$(inputs.rdr.extra)"
            },
            "rdr": {
              "source": "render"
            }
          },
          "out": [
            "html",
            "targetdir",
            "extra_out"
          ],
          "id": "makedoc",
          "run": "#makedoc",
          "scatter": [
            "rdr"
          ]
        }
      ]
    }
  ],
  "cwlVersion": "v1.0"
}
