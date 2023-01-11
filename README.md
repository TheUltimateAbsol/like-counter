Dependencies: jq and snscrape

```
sudo apt install jq
pip3 install snscrape
```

Run as a cronjob:
```
*/15 * * * * cd /data/data/com.termux/files/home/like-counter && git pull && /data/data/com.termux/files/usr/bin/bash update.sh 20 && git add index.html likes.txt followers.txt && git commit -m "data update" && git push >/dev/null 2>&1
0 1 * * * cd /data/data/com.termux/files/home/like-counter && git pull && /data/data/com.termux/files/usr/bin/bash update.sh 100 && git add index.html likes.txt followers.txt && git commit -m "data update" && git push >/dev/null 2>&1
0 0 1 * * cd /data/data/com.termux/files/home/like-counter && git pull && /data/data/com.termux/files/usr/bin/bash update.sh 3200 && git add index.html likes.txt followers.txt && git commit -m "data update" && git push >/dev/null 2>&1
```
