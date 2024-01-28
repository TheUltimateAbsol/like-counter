declare -i LIKES
declare -i VIEWS
read -r LIKES VIEWS < <(node getTweets.js 20)
declare -i FOLLOWERS=$(node getFollowers.js)
declare -i OLD_LIKES=$(tail -n 1 likes.txt | xargs echo -n)
declare -i OLD_FOLLOWERS=$(tail -n 1 followers.txt | xargs echo -n)
declare -i OLD_VIEWS=$(tail -n 1 views.txt | xargs echo -n)
declare -i LIKES_DIFFERENCE=$(expr $LIKES - $OLD_LIKES)
declare -i FOLLOWERS_DIFFERENCE=$(expr $FOLLOWERS - $OLD_FOLLOWERS)
declare -i VIEWS_DIFFERENCE=$(expr $VIEWS - $OLD_VIEWS)
echo $LIKES $FOLLOWERS $VIEWS $OLD_LIKES $OLD_FOLLOWERS $OLD_VIEWS $LIKES_DIFFERENCE $FOLLOWERS_DIFFERENCE $VIEWS_DIFFERENCE
sed -i "36s/.*/\t\t$LIKES/" index.html
sed -i "45s/.*/\t\t$FOLLOWERS/" index.html
sed -i "54s/.*/\t\t$VIEWS/" index.html
sed -i "38s/.*/\t\t\t$LIKES_DIFFERENCE/" index.html
sed -i "47s/.*/\t\t\t$FOLLOWERS_DIFFERENCE/" index.html
sed -i "56s/.*/\t\t\t$VIEWS_DIFFERENCE/" index.html
sed -i "1i $LIKES" likes.txt
sed -i "1i $FOLLOWERS" followers.txt
sed -i "1i $VIEWS" views.txt
sed -i '$d' likes.txt
sed -i '$d' followers.txt
sed -i '$d' views.txt