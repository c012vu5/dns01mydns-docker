#!/bin/sh

main () {
    trap 'exit 0' TERM
    init
    certificate
}

init () {
    sed -i /DirectEdit-master/txtedit.conf \
        -e s/yourmasterid/"${ACC}"/ \
        -e s/yourpasswd/"${PASS}"/ \
        -e s/yourdomain/"${DOMAIN}"/
}


certificate () {
    while :
    do
        if [ -e /etc/letsencrypt/live ]; then
            certbot renew
        else
            (echo Y) | \
            certbot certonly --manual \
                --non-interactive \
                --preferred-challenges=dns \
                -d "${DOMAIN}" \
                -d "*.${DOMAIN}" \
                --agree-tos \
                -m "${MAIL}" \
                --manual-auth-hook "php83 /DirectEdit-master/txtregist.php" \
                --manual-cleanup-hook "php83 /DirectEdit-master/txtdelete.php" \
                --server https://acme-v02.api.letsencrypt.org/directory
        fi
        sleep 1d &
        wait $!
    done
}

main
