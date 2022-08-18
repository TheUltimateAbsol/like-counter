Dependencies: jq and snscrape

```
sudo apt install jq
pip3 install snscrape
```

```
sed -i "15s/.*/\t\t$(snscrape --jsonl twitter-user alkalinedd | jq -n '[inputs.likeCount] | add')/" index.html
sed -i "19s/.*/\t\t$(snscrape --max-results 0 --jsonl --with-entity twitter-user alkalinedd | jq -n 'inputs.followersCount')/" index.html
```
(replaces line 15)

Run as a cronjob:
```
*/15 * * * * cd /data/data/com.termux/files/home/like-counter && git pull && sed -i "15s/.*/        $(snscrape --jsonl twitter-user alkalinedd | jq -n '[inputs.likeCount] | add')/" index.html && sed -i "19s/.*/\t\t$(snscrape --max-results 0 --jsonl --with-entity twitter-user alkalinedd | jq -n 'inputs.followersCount')/" index.html && git add index.html && git commit -m "data update" && git push >/dev/null 2>&1
```
