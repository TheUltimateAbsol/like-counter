Dependencies: jq and snscrape

```
sudo apt install jq
pip3 install snscrape
```

```
LIKES=$(snscrape --jsonl twitter-user alkalinedd | jq -n '[inputs.likeCount] | add')
FOLLOWERS=$(snscrape --max-results 0 --jsonl --with-entity twitter-user alkalinedd | jq -n 'inputs.followersCount')
OLD_LIKES=$(tail -n 1 likes.txt)
OLD_FOLLOWERS=$(tail -n 1 followers.txt)
LIKES_DIFFERENCE=$"$(($LIKES-$OLD_LIKES))"
FOLLOWERS_DIFFERENCE=$"$(($FOLLOWERS-$OLD_FOLLOWERS))"
sed -i "15s/.*/\t\t$LIKES/" index.html
sed -i "22s/.*/\t\t$FOLLOWERS/" index.html
sed -i "17s/.*/\t\t\t$LIKES_DIFFERENCE/" index.html
sed -i "24s/.*/\t\t\t$FOLLOWERS_DIFFERENCE/" index.html
sed  -i $LIKES likes.txt
sed  -i $FOLLOWERS followers.txt
sed -i '$d' likes.txt
sed -i '$d' followers.txt
```
(replaces line 15)

Run as a cronjob:
```
*/15 * * * * cd /data/data/com.termux/files/home/like-counter && git pull && /data/data/com.termux/files/usr/bin/bash update.sh && git commit -m "data update" && git push >/dev/null 2>&1
```
