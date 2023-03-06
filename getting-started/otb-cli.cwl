$graph:
- class: CommandLineTool
  id: clt

  hints:
    DockerRequirement:
      dockerPull:  terradue/otb-7.2.0:latest
  
  baseCommand: otbcli_BandMath
  
  inputs:
    il:
      inputBinding:
        position: 1
        prefix: -il
      type: string[]
    exp:
      inputBinding:
        position: 2
        prefix: -exp 
      type: string
    output:
      inputBinding:
        position: 2
        prefix: -out 
      type: string
  outputs:
    results:
      outputBinding:
        glob: .
      type: Directory
  requirements:
    EnvVarRequirement:
      envDef:
        PREFIX: /opt/anaconda/envs/env_otb
    ResourceRequirement: {}

- class: Workflow
  id: main
  doc: OTB band math

  inputs:
    image_list:
      doc: images to process
      label: images to process
      type: string[]
    expression:
      doc: band math expression
      label: band math expression
      type: string
    result: 
      doc: result
      label: result
      type: string
  label: OTB band math
  outputs:
  - id: wf_outputs
    outputSource:
    - node_1/results
    type:
      Directory
  steps:
    node_1:
      in:
        il: image_list
        exp: expression
        output: result
      out:
      - results
      run: '#clt'
cwlVersion: v1.0