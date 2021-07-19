
# All commandlets containing 'Az' in name
Get-Command -Name '*Az*' | Measure-Object


#Access Online help
Get-help get-azvm -Online






# We can access the singular properties values ( like String integer, boolean etc ).
Get-AzVM | select name, LicenseType, Location, VmId, Type, StatusCode, RequestId, ResourceGroupName




# But we CANNOT directly access the values of Collection objects or Arrays that are stored as a property.
Get-AzVM | select HardwareProfile, StorageProfile, OSProfile, BillingProfile




#*** So we need to expand such property(array/collection objects) in order to access the values stored in them.

Get-AzVM | select HardwareProfile -ExpandProperty HardwareProfile


Get-AzVM | select OSProfile -ExpandProperty OSProfile


Get-AzVM | select StorageProfile -ExpandProperty StorageProfile 
# The StorageProfile again contains objects properties only. So we can expend our desired property from this level again.

Get-AzVM | select StorageProfile -ExpandProperty StorageProfile | Select-Object ImageReference -ExpandProperty ImageReference






# Analyze your PowerShell Object

Get-AzVM | Get-Member



Get-AzVM | select *   # Select is an alias of Select-Object so this statement can also be written as :

Get-AzVM | Select-Object * 






#ASSIGNMENT

#1.) List all the Virtual Machine names in Azure within a given resource group(say demo1_group) 
#      whose name starts with  "prod" and ends with "webserver".
#     Output should be formatted in a table with only VM Name and its Resource group as columns




Get-AzVm -Name 'prod*webserver' -ResourceGroupName demo1_group | 
                Select Name, ResourceGroupName | 
                Format-Table -AutoSize





# 2.) List Virtual Machines within eastus2 or westus2 location.
    # Output should be in List format using properties: name, location, ResourceGroupName, ProvisioningState
        


Get-AzVm  | Where-Object {    ($_.Location -eq 'eastus2') -or  ($_.Location -eq 'westus2')    } | 
        Format-List name, location, ResourceGroupName, ProvisioningState






# 3.) List all Virtual Machine that are in deallocated state. Display only VM name and PowerState
    # tip:  To check the powerstate we need to pass -status switch
     Get-AzVM  -Status | Select-Object  -Property Name, PowerState


# Step A.) All VMs in deallocated state
Get-AzVM  -Status | Where-Object {$_.PowerState -eq 'VM deallocated'}



# Step B.) VMs filtered and necessary columns selected in output
Get-AzVM  -Status | Where-Object {$_.PowerState -eq 'VM deallocated'} | select name, powerstate


#     {OR}

Get-AzVM  -Status | Where-Object {$_.PowerState -eq 'VM deallocated'}  | 
    Select-Object  -Property Name, @{name='VM Power Status';  Expression = {$_.PowerState}}





# 4.) List Virtual Machines that are in running state and VMs are in eastus2 location.

Get-AzVM  -Status | Where-Object {$_.PowerState -eq 'VM running'  -and $_.Location -eq 'eastus2'}





# 5.) List Virtual Machines that are NOT in eastus2 region.

Get-AzVM  -Status | Where-Object { $_.Location -ne 'eastus2'}


#------ {OR}


Get-AzVM  -Status | Where-Object { -not ( $_.Location -eq 'eastus2') }









# Assignment Level II


# 6.) List all Virtual Machines with their OS. Display only VM name and OSType 
     # tip: To get a OS property we need to expand its StorageProfile property
	  
    Get-AzVm | select *


	
    Get-AzVm | select StorageProfile -ExpandProperty StorageProfile 




	Get-AzVm | select StorageProfile -ExpandProperty StorageProfile | select OsDisk -ExpandProperty OsDisk





	Get-AzVm | select StorageProfile -ExpandProperty StorageProfile | 
            select OsDisk -ExpandProperty OsDisk | 
            select OsType -ExpandProperty OsType



Get-AzVm | select StorageProfile -ExpandProperty StorageProfile | 
            select OsDisk -ExpandProperty OsDisk | 
            select OsType -ExpandProperty OsType |
            select name, OsType



	
	

    Get-AzVm | Select-Object -Property Name, @{ name='My OS Type';  Expression = { $_.StorageProfile.OsDisk.OsType }}





# 7.) List all Virtual Machines that has Linux OS
Get-AzVm | Where-Object  {$_.StorageProfile.OsDisk.OsType -eq 'Linux'}

    
# To list Windows VMs
    #Get-AzVm | Where-Object  {$_.StorageProfile.OsDisk.OsType -eq 'Windows'}






# 8.) List all VMs with their VM Size
Get-AzVm | Select-Object -Property Name, @{name='Size';  Expression = {$_.HardwareProfile.VmSize}}



 
 

# 9.) 8.	List all Virtual Machines that are in D series of VM size
Get-AzVm | Where-Object  {$_.HardwareProfile.VmSize -like '*_D*'}
 





# 10.) List all Virtual Machines that are of D series Vm size and resource group name contains word 'demo'
        # Output should be a table with only 3 columns : VM Name, VM Size, VM OS
Get-AzVm | Select-Object HardwareProfile -ExpandProperty HardwareProfile | select VmSize


Get-AzVm | Where-Object  {$_.HardwareProfile.VMSize -like '*_D*'    -and $_.ResourceGroupName -like 'demo*' } |
            Select-Object -Property Name `
                                    , @{name='VMSize';  Expression = {$_.HardwareProfile.VmSize}}  `
                                    , @{name='OsType';  Expression = {$_.StorageProfile.OsDisk.OsType}}





# 11.) List all Virtual Machine that satisfy below conditions
#     Status : 		    stopped
#     Region  : 		eus2
#     Resource Group : 	demo_group1
#     OS	: 	        Windows (any version)

# In output, display only  VM name, ProvisioningState, VMSize and OSType


Get-AzVm -Status | Where-Object  { $_.PowerState -like '*deallocated*' `
                            -and $_.Location -like 'eastus2'  `
                            -and $_.ResourceGroupName -eq 'demo1_group'  `
                            -and $_.StorageProfile.OsDisk.OsType -like '*windows*' `
                          } |
                     Select-Object -Property Name, ProvisioningState `                     `
                                    , @{name='VMSize';  Expression = {$_.HardwareProfile.VmSize}}  `
                                    , @{name='OsType';  Expression = {$_.StorageProfile.OsDisk.OsType}}





