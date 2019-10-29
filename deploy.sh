git add .
git commit -m $1
git push origin master
ssh root@51.91.126.117 <<EOF
cd aulahaskadsm & git pull origin master & stack build
EOF
