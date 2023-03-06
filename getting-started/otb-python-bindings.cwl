$graph:
- class: CommandLineTool
  id: clt
  
  requirements:
  - class: EnvVarRequirement
    envDef: {}
  - class: ResourceRequirement
  - class: DockerRequirement
    dockerPull: terradue/otb-7.2.0:latest
  - class: InitialWorkDirRequirement
    listing:
      - entryname: otb.py
        entry: |-
          import sys
          import otbApplication
          print(sys.argv)
          app = otbApplication.Registry.CreateApplication("BandMathX")

          app.SetParameterStringList("il", sys.argv[3:])
          app.SetParameterString("exp", sys.argv[1])
          app.SetParameterString("out", sys.argv[2])
          

          app.ExecuteAndWriteOutput()
  
  baseCommand: ["python", "otb.py"]
  
  inputs:
    exp: 
      inputBinding:
        position: 1 
      type: string
    output:
      inputBinding:
        position: 2 
      type: string
    il:
      inputBinding:
        position: 3
      type: string[]
    
  outputs:
    results:
      outputBinding:
        glob: .
      type: Directory
  
- class: Workflow
  doc: OTB band math
  id: main
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