#!/bin/bash

name="demo.dot"
output="demo-output.dot"
edges="demo-edges.json"
nodes="demo-nodes.json"
temp="tmp"
mkdir $temp 
gvpr -c "E[match($.tail.label, 'CONAN_LIB::') == 0 || match($.tail.label, 'CONAN_LIB::') == 0]{delete(NULL, $);}" $name -o $temp/tmp.dot
gvpr -c "N[match($.label, 'CONAN_LIB::') == 0]{delete(NULL, $);}" $temp/tmp.dot -o $temp/tmp2.dot

# remove legend
gvpr -c "E[match($.tail.name, 'legendNode') == 0 || match($.tail.name, 'legendNode') == 0]{delete(NULL, $);}" $temp/tmp2.dot -o $temp/tmp3.dot
gvpr -c "N[match($.name, 'legendNode') == 0]{delete(NULL, $);}" $temp/tmp3.dot -o $temp/tmp4.dot
gvpr -c "BEG_G{ if (isSubg($, 'clusterLegend') != NULL) delete($, isSubg($, 'clusterLegend')); }" $temp/tmp4.dot -o $output
# to json
echo "[" > $nodes
gvpr -c "N[]{print('{ \"id\": ', substr($.name, 4), ', \"label\": \"', $.label, '\" , \"shape\": \"box\", \"fulllabel\": \"none\", \"color\": { \"background\": \"SkyBlue\"} },')}" $output -o /dev/null >> $nodes
echo "]" >> $nodes
echo "[" > $edges
gvpr -c "E[]{print('{ \"from\": ', substr($.head.name, 4), ', \"to\": ', substr($.tail.name, 4),' }, ')}" $output -o /dev/null >> $edges
echo "]" > $edges
#rm tmp.dot
