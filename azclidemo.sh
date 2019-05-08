#!/usr/bin/env bash


# Read Input parameters from a file
source ./input.txt
#Create Resource Group
az group create -g $resourcegroup -l $location --subscription "8d4847a9-69e0-421a-a34c-bdbe015475c7"
#Check if Resource Group creation is a success
if [ $? == 0 ];
then
    echo "Resource Group $resourcegroup created in $location"
    #Creating VM
    echo "Proceeding to create Virtual machine $vmname"
    az vm create -g $resourcegroup -l $location -n $vmname \
                --image $image  \
                --public-ip-address-allocation dynamic \
                 --size $vmsize --admin-username $adminusrename \
                 --admin-password $adminpasswd --authentication-type password
    if [ $? == 0 ];
    then
      echo "Virtual Machine $vmname created"
    else
      echo "Error occured in creating Virtual machine"
    fi
else
  echo "Error occured in creating Resource Group"
fi
