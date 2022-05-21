#!/bin/bash
if [ -f setup.env ]; then
    adguard_password=$(grep "adguard_password=" setup.env|cut -d "=" -f2|tr -d "'" )
    adguard_username=$(grep "adguard_username=" setup.env |cut -d "=" -f2|tr -d "'")
    traefik_username=$(grep "traefik_username=" setup.env |cut -d "=" -f2|tr -d "'")
    traefik_password=$(grep "traefik_password=" setup.env |cut -d "=" -f2|tr -d "'")
else
   echo "setup.env doesn't exists"
fi

adguard_password=$(echo $adguard_password | htpasswd -nBi -C 10 "" |  tr -d ':\n')
traefik_password=$(echo $traefik_password | htpasswd -nBi -C 10 "" |  tr -d ':\n')

if [ ! -f confdir/AdGuardHome.template.yaml ]; then
    echo "AdGuardHome.template.yaml not found"
fi

if [ ! -f docker-compose.yml ]; then
    echo "docker-compose.yml not found"
fi

sed  -e "s:\${AGH_USERNAME}:'$adguard_username':g" -e "s:\${AGH_PASSWORD}:'$adguard_password':g" confdir/AdGuardHome.template.yaml > confdir/AdGuardHome.yaml
echo "$traefik_username:$traefik_password" > traefikUsersFile