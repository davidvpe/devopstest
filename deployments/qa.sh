sudo npm install -g --unsafe-perm now
echo "deploying..."
echo "now --docker --public -t $NOW_TOKEN"
URL_NOW=$(now --docker --public -t $NOW_TOKEN)
echo "running acceptance on... $URL_NOW"
curl --silent -L $URL_NOW