# Q15 notes
Plain nginx:1-alpine serves on port 80 by default, so `curl POD_IP:1111`
and `:2222` (as the original question's connectivity test implies) won't
actually hit anything unless you also make nginx listen on those ports.
For a faithful repro, exec into db1-0/db2-0 and add a second `listen 1111;`
/ `listen 2222;` server block to /etc/nginx/conf.d/default.conf and reload,
or just test against port 80 instead — the NetworkPolicy logic you're
practicing (egress rules with AND vs OR conditions) is identical either way.
