# Start Azure VM
Start-AzVM


# Get-Help
Get-Help Start-AzVM -ShowWindow

# Start VM
Start-AzVM -ResourceGroupName "ResourceGroup11" -Name "VirtualMachine07"


# Start Selected VMs
Get-AzVm | Where-Object { $_.Location -eq 'eus2' } | 
            Where-Object { $_.OsName -eq 'windows' } |
            Start-AzVM
			
			
			
			

# Start Azure VM
Stop-AzVM


# Get-Help
Get-Help Stop-AzVM -ShowWindow

# Stop VM
Stop-AzVM -ResourceGroupName "ResourceGroup11" -Name "VirtualMachine07"


# Stop Selected VMs
Get-AzVm | Where-Object { $_.Location -eq 'eus2' } | 
            Where-Object { $_.OsName -eq 'windows' } |
            Stop-AzVM