function Send-TwitterSavedSearches_Destroy_Id {
<#
.SYNOPSIS
    Manage account settings and profile

.DESCRIPTION
    POST saved_searches/destroy/:id
    
    Destroys a saved search for the authenticating user. The authenticating user must be the owner of saved search id being destroyed.

.PARAMETER id
    The ID of the saved search.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/manage-account-settings/api-reference/post-saved_searches-destroy-id

#>
    [CmdletBinding()]
    Param(
        [string]$id
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/saved_searches/destroy/:id'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/saved_searches/destroy/:id.json'

    }
    Process {

        # Find & Replace any ResourceUrl parameters.
        $UrlParameters = [regex]::Matches($ResourceUrl, '(?<!\w):\w+')
        ForEach ($UrlParameter in $UrlParameters) {
            $UrlParameterValue = $Parameters["$($UrlParameter.Value.TrimStart(":"))"]
            $ResourceUrl = $ResourceUrl -Replace $UrlParameter.Value, $UrlParameterValue
        }

        $OAuthSettings = Get-TwitterOAuthSettings -Resource $Resource
        Invoke-TwitterAPI -Method $Method -ResourceUrl $ResourceUrl -Parameters $Parameters -OAuthSettings $OAuthSettings

    }
    End {

    }
}
