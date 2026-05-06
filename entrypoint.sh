#!/bin/bash

# Create the user if they don't exist
if [ ! -z "$OOD_TEST_USER" ] && [ ! -z "$OOD_TEST_PASS" ]; then
    if ! id "$OOD_TEST_USER" &>/dev/null; then
        useradd -m -s /bin/bash "$OOD_TEST_USER"
        echo "$OOD_TEST_USER:$OOD_TEST_PASS" | chpasswd
        echo "Created user $OOD_TEST_USER"
    fi
fi

# Hand off to systemd (the original CMD)
exec /sbin/init
