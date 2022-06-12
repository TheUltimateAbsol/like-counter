Dependencies: jq and snscrape

```
sudo apt install jq
pip3 install snscrape
```

```
sed -i "15s/.*/\t\t$(snscrape --jsonl twitter-user alkalinedd | jq -n '[inputs.likeCount] | add')/" index.html
```
(replaces line 15)