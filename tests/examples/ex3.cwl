#!/usr/bin/env cwl-runner
arguments:
  - rev
  - $(inputs.msg)
class: CommandLineTool
cwlVersion: v1.0
id: '#reverse'
inputs:
  - id: msg
    type: File
outputs:
  - id: reversed
    outputBinding:
      glob: reversed.txt
    type: File
requirements:
  - class: DockerRequirement
    dockerPull: 'debian:9'
stdout: reversed.txt

