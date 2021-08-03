$graph:
- class: Workflow
  label: NBR - produce the normalized difference between NIR and SWIR 22 
  doc: NBR - produce the normalized difference between NIR and SWIR 22 
  id: main

  requirements:
  - class: ScatterFeatureRequirement

  inputs:
    stac_item: 
      doc: Landsat-8 item
      type: string
    aoi: 
      doc: area of interest as a bounding box
      type: string
    xs_bands: 
      type: string[]
      default: ["B4", "B3", "B2"]
    p_band:
      type: string
      default: "B8"
  
  outputs:
    nbr:
      outputSource:
      - node_bundle_to_perfect/pan-sharpened
      type: File

  steps:

    node_stac_xs:
    
      run: asset.cwl
        
      in:
        stac_item: stac_item
        asset: xs_bands

      out:
        - asset_href

      scatter: asset
      scatterMethod: dotproduct 
    
    node_stac_p:
    
      run: asset.cwl
        
      in:
        stac_item: stac_item
        asset: p_band

      out:
        - asset_href

    node_subset_xs:

      run: translate.cwl  

      in: 
        asset: 
          source: node_stac_xs/asset_href
        bbox: aoi

      out:
      - tifs
        
      scatter: asset
      scatterMethod: dotproduct

    node_subset_p:

      run: translate.cwl  

      in: 
        asset: 
          source: node_stac_p/asset_href
        bbox: aoi

      out:
      - tifs
        
    node_concatenate:
    
      run: concatenate.cwl

      in:
        tifs: 
          source: [node_subset_xs/tifs]
      
      out:
      - xs_stack

    node_bundle_to_perfect:

      run: bundle_to_perfect.cwl

      in:
        xs:
          source: [node_concatenate/xs_stack]
        pan:
          source: [node_subset_p/tifs]
      
      out:
      - pan-sharpened

cwlVersion: v1.0