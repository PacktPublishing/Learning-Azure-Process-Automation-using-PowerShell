# Get List of Resource groups
Get-AzResourceGroup


# Filter by name
Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -like 'c*'}

# Filter by location location 
Get-AzResourceGroup | Where-Object { $_.Location -eq 'westus'}


# Filter and Fortmat Output
Get-AzResourceGroup | Where-Object { $_.Location -eq 'westus'} | Format-Table -AutoSize 

Get-AzResourceGroup | Where-Object { $_.Location -eq 'westus'} | Format-List








# Filter, Select and Format Output
Get-AzResourceGroup | Where-Object { $_.Location -eq 'westus'} | 
    Select-Object ResourceGroupName, Location, ProvisioningState |
    Format-Table -AutoSize  


# Filter, Select and Format Output
Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -like 'c*' } | 
    Select-Object ResourceGroupName, Location, ProvisioningState |
    Format-List




# List differnt Virtual Machines
Get-AzVM 

Get-AzVM | select *




# VM data export to CSV
Get-AzVM  | select Name,Type, Location, StatusCode  |  Export-Csv -Path 'azure_vms.csv' 

# Export all resources by resourcegroup name
Get-AzResource -ResourceGroupName 'computercompute' |  Export-Csv -Path 'azure_resources.csv'  -NoTypeInformation
 
# Export selected Azure resources
Get-AzResource |  Where-Object { $_.Location -eq 'westus'} |
            Where-Object { $_.ResourceType -ne 'Microsoft.Compute/virtualMachines' }
            Select ResourceGroupName, Name, ResourceType |
            Export-Csv -Path 'selected_azure_resources.csv' -NoTypeInformation



# Export to JSON Format
 $data = Get-AzResource |  Where-Object { $_.Location -eq 'westus'} |
            Where-Object { $_.ResourceType -ne 'Microsoft.Compute/virtualMachines' } |
            Select ResourceGroupName, Name, ResourceType 

 $data |  ConvertTo-Json  | Out-File "export_data.json"


 # Export to XML
 $data | Export-Clixml -Path "Test.xml"


 # Export to HTML file 
  $data | ConvertTo-Html -Property * | out-file test.html