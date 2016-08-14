#!/bin/bash

# Usage: newScript creds source

: '

Pseudocode

    tag1Key = source
    tag1Value = bestbuy
    tag2Key = producttype

For every dir

    tag2Value = dir

    for every subdir in dir

    make new visual with name from subdir

    for every image in subdir

        add the image to the new visual

'

creds="$1"

source="$2"

projectNo="$3"

tag1Key='source'
tag1Value='Best Buy'
tag2Key='category'

tag2Value=''

for dir in "$source"/*; do
    tag2Value=`basename "$dir"`

      for subDir in "$dir"/*; do
          
          visName=`basename "$subDir"`
          visID=`curl -i -X POST -u "$creds" https://cloud.ltutech.com/api/v1/projects/"$projectNo"/visuals/ -F title="$visName" -F name="$visName" -F metadata-0-key="$tag1Key" -F metadata-0-value="$tag1Value" -F metadata-1-key="$tag2Key" -F metadata-1-value="$tag2Value" | tail -1 | python -mjson.tool | grep \"id\" | head -1 | grep -oP '\d*'`

          for image in "$subDir"/*; do

              curl -i -X POST -u "$creds" https://cloud.ltutech.com/api/v1/projects/visuals/"$visID"/images/ -F image=@"$image"

          done

      done

done

