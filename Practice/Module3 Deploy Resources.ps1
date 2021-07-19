

# Deploy a simple VM with no customizations
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."
New-AzVm -Name "TestVM"  -Credential $cred


Get-Help New-AzVm






# Method 1
# Deploying an Aure VM with additional options
New-AzVm -ResourceGroupName "azuretest-rg" -Name "myTestVM" -Location "East US" -VirtualNetworkName "myTest-vnet" -SubnetName "myTest-subnet" -OpenPorts 80,3389 -Image Win2016Datacenter
	

# Method 2	
# Deploying an Aure VM with additional options
New-AzVm `
    -ResourceGroupName "azuretest-rg" `
    -Name "myTestVM" `
    -Location "East US" `
    -VirtualNetworkName "myTest-vnet" `
    -SubnetName "myTest-subne" `
    -OpenPorts 80,3389 `
    -Image Win2016Datacenter

    
	
# Method 3
# Deploying an Aure VM with additional options
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."
$vmParams = @{
   ResourceGroupName = "azuretest-rg"
   Name = "myTestVM" 
   Location = "East US" 
   VirtualNetworkName = "myTest-vnet"
   SubnetName = "myTest-subnet"
   OpenPorts = 80,3389
   Image = 'Win2016Datacenter'
}

$newVM = New-AzVM @vmParams

