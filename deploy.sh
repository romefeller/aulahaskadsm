git add .
git commit -m $1
git push origin master
ssh root@51.91.126.117 <<EOF
git pull origin master
stack build
<<EOF
