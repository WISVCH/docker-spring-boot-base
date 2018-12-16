#!/bin/sh

case $1 in
	*.jar )
		if [ `id -u` -ne 999 ]; then
			echo "Refusing to run as user other than spring-boot"
			exit 1
		fi
		exec /usr/bin/java -XX:+ExitOnOutOfMemoryError -XshowSettings:vm $JAVA_OPTS -jar $1
		;;
esac

if [ $# -eq 0 ]; then
	exec /bin/bash
else
	exec "$@"
fi
