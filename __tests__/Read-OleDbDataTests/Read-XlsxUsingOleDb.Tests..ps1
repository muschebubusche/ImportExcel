#Requires -Modules Pester
$scriptPath = $PSScriptRoot
Import-Module $scriptPath\..\..\ImportExcel.psd1 -Force
$tfp = "$scriptPath\Read-OleDbData.xlsx"
$ACEnotWorking = $false
try {
    $Results = Read-XlsxUsingOleDb $tfp "select 1"      
}
catch {
    $ACEnotWorking = $true
}
Describe "Read-XlsxUsingOleDb" -Tag "Read-XlsxUsingOleDb" {
    $PSDefaultParameterValues = @{ 'It:Skip' = $ACEnotWorking }
    Context "Sheet1`$A1" {
        It "Should return 1 result with a value of 1" {
            $Results = Read-XlsxUsingOleDb $tfp "select ROUND(F1) as [A1] from [sheet1`$A1:A1]"
            @($Results).length + $Results.A1 | Should -Be 2
        }
    }
}
