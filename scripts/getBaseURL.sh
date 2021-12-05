sfdx force:apex:execute -f apex/getBaseUrl.apex > output.txt
line=sed -e 's#.*=\(\)#\1#' <<< awk '/DEBUG/{print}' output.txt 
echo $line