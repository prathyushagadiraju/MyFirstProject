#get the most recent deployment for the resource group
$lastRgDeployment = Get-AzureRmResourceGroupDeployment -ResourceGroupName "newresourcgroup" |
    Sort Timestamp -Descending |
        Select -First 1        

if(!$lastRgDeployment)
{
    throw "Resource Group Deployment could not be found for '$resourceGroupName'."
}

$deploymentOutputParameters = $lastRgDeployment.Outputs

if(!$deploymentOutputParameters)
{
    throw "No output parameters could be found for the last deployment of '$resourceGroupName'."
}

$outputParameter = $deploymentOutputParameters.Item($rgDeploymentOutputParameterName)

if(!$outputParameter)
{
    throw "No output parameter could be found with the name of '$rgDeploymentOutputParameterName'."
}

$outputParameterValue  = $outputParameter.Value

# From here, use $outputParameterValue, for example:
Write-Host "##vso[task.setvariable variable=$rgDeploymentOutputParameterName;]$outputParameterValue"