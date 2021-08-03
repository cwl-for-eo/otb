# BandMathX

The command wrapped by the CWL `CommandLineTool` is:

```console
 otbcli_BandMathX \
    -out \
    S2B_53HPA_20210723_0_L2A.tif \
    -exp \
    '(im3b1 == 8 or im3b1 == 9 or im3b1 == 0 or im3b1 == 1 or im3b1 == 2 or im3b1 == 10 or im3b1 == 11) ? -2 : (im1b1 - im2b1) / (im1b1 + im2b1)' \
    -il \
    /vsicurl/https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/53/H/PA/2021/7/S2B_53HPA_20210723_0_L2A/B8A.tif \
    /vsicurl/https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/53/H/PA/2021/7/S2B_53HPA_20210723_0_L2A/B12.tif \
    /vsicurl/https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/53/H/PA/2021/7/S2B_53HPA_20210723_0_L2A/SCL.tif
```

The CWL document content is:

```yaml
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement: 
    dockerPull: terradue/otb-7.2.0

baseCommand: otbcli_BandMathX
arguments: 
- -out
- valueFrom: ${ return inputs.stac_item.split("/").slice(-1)[0] + ".tif"; }
- -exp
- '(im3b1 == 8 or im3b1 == 9 or im3b1 == 0 or im3b1 == 1 or im3b1 == 2 or im3b1 == 10 or im3b1 == 11) ? -2 : (im1b1 - im2b1) / (im1b1 + im2b1)'

inputs:

  tifs:
    type: string[]
    inputBinding:
      position: 5
      prefix: -il
      separate: true
  
  stac_item:
    type: string
    
outputs:

  nbr:
    outputBinding:
      glob: "*.tif"
    type: File

cwlVersion: v1.0
```

It may be run with the parameters:

```yaml
stac_item: "https://earth-search.aws.element84.com/v0/collections/sentinel-s2-l2a-cogs/items/S2B_53HPA_20210723_0_L2A"
tifs: 
- /vsicurl/https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/53/H/PA/2021/7/S2B_53HPA_20210723_0_L2A/B8A.tif 
- /vsicurl/https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/53/H/PA/2021/7/S2B_53HPA_20210723_0_L2A/B12.tif 
- /vsicurl/https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/53/H/PA/2021/7/S2B_53HPA_20210723_0_L2A/SCL.tif 
```

The execution will generate:

```console
INFO /srv/conda/bin/cwltool 3.0.20210319143721
INFO Resolved 'band_math.cwl' to 'file:///home/fbrito/work/otb/bandmathx/band_math.cwl'
INFO [job band_math.cwl] /tmp/auat4iwq$ docker \
    run \
    -i \
    --mount=type=bind,source=/tmp/auat4iwq,target=/TpzBuz \
    --mount=type=bind,source=/tmp/f5kk5k5o,target=/tmp \
    --workdir=/TpzBuz \
    --read-only=true \
    --user=1000:1000 \
    --rm \
    --env=TMPDIR=/tmp \
    --env=HOME=/TpzBuz \
    --cidfile=/tmp/rt3b0xri/20210803121503-843162.cid \
    terradue/otb-7.2.0 \
    otbcli_BandMathX \
    -out \
    S2B_53HPA_20210723_0_L2A.tif \
    -exp \
    '(im3b1 == 8 or im3b1 == 9 or im3b1 == 0 or im3b1 == 1 or im3b1 == 2 or im3b1 == 10 or im3b1 == 11) ? -2 : (im1b1 - im2b1) / (im1b1 + im2b1)' \
    -il \
    /vsicurl/https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/53/H/PA/2021/7/S2B_53HPA_20210723_0_L2A/B8A.tif \
    /vsicurl/https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/53/H/PA/2021/7/S2B_53HPA_20210723_0_L2A/B12.tif \
    /vsicurl/https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/53/H/PA/2021/7/S2B_53HPA_20210723_0_L2A/SCL.tif
2021-08-03 10:16:52 (INFO) BandMathX: Default RAM limit for OTB is 256 MB
2021-08-03 10:16:52 (INFO) BandMathX: GDAL maximum cache size is 3197 MB
2021-08-03 10:16:52 (INFO) BandMathX: OTB will use at most 16 threads
2021-08-03 10:16:52 (INFO) BandMathX: Image #1 has 1 components
2021-08-03 10:16:52 (INFO) BandMathX: Image #2 has 1 components
2021-08-03 10:16:52 (INFO) BandMathX: Image #3 has 1 components
2021-08-03 10:16:52 (INFO) BandMathX: Using expression: (im3b1 == 8 or im3b1 == 9 or im3b1 == 0 or im3b1 == 1 or im3b1 == 2 or im3b1 == 10 or im3b1 == 11) ? -2 : (im1b1 - im2b1) / (im1b1 + im2b1)
2021-08-03 10:16:52 (INFO): Estimated memory for full processing: 574.839MB (avail.: 256 MB), optimal image partitioning: 3 blocks
2021-08-03 10:16:52 (INFO): File S2B_53HPA_20210723_0_L2A.tif will be written in 4 blocks of 3072x3072 pixels
Writing S2B_53HPA_20210723_0_L2A.tif...: 100% [**************************************************] (26s)
INFO [job band_math.cwl] Max memory used: 338MiB
INFO [job band_math.cwl] completed success
{
    "nbr": {
        "location": "file:///home/fbrito/work/otb/bandmathx/S2B_53HPA_20210723_0_L2A.tif",
        "basename": "S2B_53HPA_20210723_0_L2A.tif",
        "class": "File",
        "checksum": "sha1$6f1b9a5230e53d9bf30ee1c1b09b8aa2e9d45d6b",
        "size": 120604786,
        "path": "/home/fbrito/work/otb/bandmathx/S2B_53HPA_20210723_0_L2A.tif"
    }
}
INFO Final process status is success
```