# For languages that can't be displayed on Linux console, we have, e.g.:
# LC_ALL=C, LANG=zh_CN.UTF-8
# Remove LC_ALL now so that LANG takes effect
unset LC_ALL
scim -d
exec startxfce4
