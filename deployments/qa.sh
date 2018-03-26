sudo npm install -g now
echo "deploying..."
echo "now --docker -t $NOW_TOKEN"
$URL=$(now --docker -t $NOW_TOKEN)
echo "running acceptance on... $URL"
curl --silent -L $URL



