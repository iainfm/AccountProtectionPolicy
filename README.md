# Account Protection Policy

## Create and assign an Intune account protection policy using Powershell and MS-Graph

Sample script in case it helps anyone, because it took me ages to figure out and there wasn't much else available to plagiarise at the time :)

One gotcha I found was that unless the case of the UPN matches the Intune/AAD record exactly it doesn't get displayed in Endpoint Manager. To get around this you can grab it before adding it with:

`$DaAadAccount = (Get-MgUser -Filter "id eq '$DaAccountUpn'")`

`$DaAccountUpn = $DaAadAccount.UserPrincipalName`
