#This progam will modularise creation of resource group and vms

function create-vnet() {
  # Expects to be called as create-vnet <vnet name> <resource group> <address-prefixes/CIDR-Block> <tags>
  az network vnet create --name $1 --resource-group $2 --address-prefixes $3 --tags $4

}

function create-subnet() {
  # Expects to be called as `create-subnet <subnetname> <resourcegroup> <vnetname> <address-prefixes/CIDR-Bloc> <nsg_name>  `
  az network vnet subnet create  --name $1 --resource-group $2 \
                                 --vnet-name $3 --address-prefixes $4 \
                                 --network-security-group $5
}


function create-rg() {
  # Expects to be called as create-rg <resourcregroupname> <location>
  az group create --name $1 --location $2
}

function create-vm() {
  #Expects to be called as `create-vm <vmname> <resourcregroupname> <location> <adminusername> <ssh-key-path> <image> <vmsize> <subnetname>
  az vm create --name $1 --resource-group $2 --location $3 --admin-username $4 \
               --ssh-key-value $5 --image $6 --size $7 --vnet-name $8 --subnet $9 \
               --authentication-type ssh --public-ip-address-allocation dynamic
}
