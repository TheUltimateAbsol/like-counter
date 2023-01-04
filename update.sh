declare -i LIKES=$(snscrape --jsonl twitter-user alkalinedd | jq -n '[inputs.likeCount] | add' | xargs echo -n)
declare -i FOLLOWERS=$(snscrape --max-results 0 --jsonl --with-entity twitter-user alkalinedd | jq -n 'inputs.followersCount' | xargs echo -n)
declare -i OLD_LIKES=$(tail -n 1 likes.txt | xargs echo -n)
declare -i OLD_FOLLOWERS=$(tail -n 1 followers.txt | xargs echo -n)
declare -i LIKES_DIFFERENCE=$(expr $LIKES - $OLD_LIKES)
declare -i FOLLOWERS_DIFFERENCE=$(expr $FOLLOWERS - $OLD_FOLLOWERS)
echo $LIKES $FOLLOWERS $OLD_LIKES $OLD_FOLLOWERS $LIKES_DIFFERENCE $FOLLOWERS_DIFFERENCE
sed -i "15s/.*/\t\t$LIKES/" index.html
sed -i "22s/.*/\t\t$FOLLOWERS/" index.html
sed -i "17s/.*/\t\t\t$LIKES_DIFFERENCE/" index.html
sed -i "24s/.*/\t\t\t$FOLLOWERS_DIFFERENCE/" index.html
sed -i "1i $LIKES" likes.txt
sed -i "1i $FOLLOWERS" followers.txt
sed -i '$d' likes.txt
sed -i '$d' followers.txt