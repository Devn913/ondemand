#!/bin/bash

# Create the user if they don't exist
if [ ! -z "$OOD_TEST_USER" ] && [ ! -z "$OOD_TEST_PASS" ]; then
    if ! id "$OOD_TEST_USER" &>/dev/null; then
        useradd -m -s /bin/bash "$OOD_TEST_USER"
        echo "$OOD_TEST_USER:$OOD_TEST_PASS" | chpasswd
        echo "Created user $OOD_TEST_USER"
        
        # Setup HTBpasswd for Apache Basic Auth
        dnf install -y httpd-tools
        htpasswd -b -c /etc/httpd/conf.d/ood-portal.htpasswd "$OOD_TEST_USER" "$OOD_TEST_PASS"
    fi
fi

# Generate the OOD portal config
/opt/ood/ood-portal-generator/sbin/update_ood_portal

# Hand off to systemd (the original CMD)
exec /sbin/init
