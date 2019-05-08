#!/usr/bin/env bash

source ./input.txt
. ./azdemo_function.sh

:<<'END'
#Create Resource Group
create-rg $resourcegroup $location

#Create NSG and Security Rules

az network nsg create --name $nsg_name  --resource-group $resourcegroup

az network nsg rule create --name ssh --nsg-name $nsg_name  \
                           --resource-group $resourcegroup --priority 100 \
                           --access Allow --direction Inbound --protocol Tcp \
                           --destination-port-ranges '22' --source-port-ranges '*' \
                           --destination-address-prefixes '*' --source-address-prefixes '*'


az network nsg rule create  --name web --nsg-name $nsg_name  \
                            --resource-group $resourcegroup --priority 200 \
                            --access Allow --direction Inbound --protocol Tcp \
                            --destination-port-ranges '80' --source-port-ranges '*' \
                            --destination-address-prefixes '*' --source-address-prefixes '*'


#Create Virtual Netwrok
create-vnet $vnetname $resourcegroup $vnetcidr $tags

sleep 45

create-subnet $subnetname $resourcegroup $vnetname $subnetcidr $nsg_name

sleep 45
END

create-vm $vmname $resourcegroup $location $username $sshkeypath $image $vmsize $vnetname $subnetname
