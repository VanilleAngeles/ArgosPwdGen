#!/usr/bin/env bash
# this program generate a new password every time we launch the option
# the generated password can be copied in the clipboard for past usage (click on it)
# Exemples of programming are found in wiki Argos --> https://github.com/p-e-w/argos/wiki
#
# Otions Choice
BoolUpper=true
BoolLower=true
BoolNumbr=true
BoolSpecl=false
LngPwd=12
# Clipboard Copy
function enable_copy_paste {
 echo "bash='echo -n $1 | xclip -selection c && echo -n $1 | xclip' terminal=false"
 }
# Authorized characters
Upper='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
Lower='abcdefghijklmnopqrstuvwxyz'
Numbr='0123456789'
Specl="\`'\"\\!#$%&()*+,-:;<=>?@[]^_{|}~"
# Init
Pwd=''; Auth=''; LssPwd=0; EndPwd=0
# Generate authrised characters list and choice a character of each category selected
if [ "$BoolUpper" = true ]; then Auth=$Auth$Upper; X=${#Upper}; Y=$(expr $RANDOM % $X); R=${Upper:$Y:1}; LssPwd=$((LssPwd+1)); Pwd="$Pwd$R"; fi
if [ "$BoolLower" = true ]; then Auth=$Auth$Lower; X=${#Lower}; Y=$(expr $RANDOM % $X); R=${Lower:$Y:1}; LssPwd=$((LssPwd+1)); Pwd="$Pwd$R"; fi
if [ "$BoolNumbr" = true ]; then Auth=$Auth$Numbr; X=${#Numbr}; Y=$(expr $RANDOM % $X); R=${Numbr:$Y:1}; LssPwd=$((LssPwd+1)); Pwd="$Pwd$R"; fi
if [ "$BoolSpecl" = true ]; then Auth=$Auth$Specl; X=${#Specl}; Y=$(expr $RANDOM % $X); R=${Specl:$Y:1}; LssPwd=$((LssPwd+1)); Pwd="$Pwd$R"; fi
EndPwd=$((LngPwd-LssPwd))
X=${#Auth}
# fill the password
while [[ $EndPwd -ne 0 ]]
do
	Y=$(expr $RANDOM % $X)
	R=${Auth:$Y:1}
	Pwd="$Pwd$R"
	EndPwd=$((EndPwd-1))
done
# Shuffle the password
Pwd=$(echo $Pwd | fold -w1 | shuf | tr -d '\n') 
# Display Result
#	Standard Emojs could be find in this Gnome extension: https://extensions.gnome.org/extension/1162/emoji-selector/
#	Standard icons could be find in terminal command: gtk3-icon-browser
echo '☀🔐'
echo "---"
echo 'Click on Password to <b>xclip</b>'
printf "%s" $Pwd
echo " | $(enable_copy_paste $Pwd) refresh=true iconName=dialog-password"
