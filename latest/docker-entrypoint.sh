#!/bin/sh
set -e

USERNAME="docker"
GROUPNAME="$USERNAME"

UID=`stat --format=%u "$(pwd)"`
GID=`stat --format=%g "$(pwd)"`

[ $UID -gt 0 ] || exit 2
[ $GID -gt 0 ] || exit 3

grep -q "^$GROUPNAME:x:$GID:" /etc/group ||\
    groupadd --non-unique --gid "$GID" "$GROUPNAME" || exit $?

grep -q "^$USERNAME:x:$UID:$GID:" /etc/passwd ||\
    useradd --home-dir "$(pwd)" --no-create-home\
        --gid "$GID" --no-user-group\
        --uid "$UID" "$USERNAME" || exit $?

composer install
php bin/console doctrine:schema:update -f

if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"