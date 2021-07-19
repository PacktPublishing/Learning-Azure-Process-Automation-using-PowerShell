$vmName = 'demovm1'
$resourceGroup='az203'



Get-AzVM -ResourceGroupName $resourceGroup -VMName $vmName

# Get the VM Size
$vm = Get-AzVM -ResourceGroupName $resourceGroup -VMName $vmName
$vm.HardwareProfile.VmSize

#{or}
( Get-AzVM -ResourceGroupName $resourceGroup -VMName $vmName ).HardwareProfile.VmSize




#Available VM sizes for our VM
Get-AzVMSize -ResourceGroupName $resourceGroup -VMName $vmName 



# Update the VM size, If desired VM size is available in above list
$vm.HardwareProfile.VmSize = "<newVMsize>"
Update-AzVM -VM $vm -ResourceGroupName $resourceGroup




# Update the VM size
Stop-AzVM -ResourceGroupName $resourceGroup -Name $vmName -Force
$vm = Get-AzVM -ResourceGroupName $resourceGroup -VMName $vmName
$vm.HardwareProfile.VmSize = "<newVMSize>"
Update-AzVM -VM $vm -ResourceGroupName $resourceGroup
Start-AzVM -ResourceGroupName $resourceGroup -Name $vmName

