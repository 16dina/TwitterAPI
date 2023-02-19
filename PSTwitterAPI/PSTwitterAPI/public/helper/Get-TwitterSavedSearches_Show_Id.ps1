﻿function Get-TwitterSavedSearches_Show_Id {
<#
.SYNOPSIS
    Manage account settings and profile

.DESCRIPTION
    GET saved_searches/show/:id
    
    Retrieve the information for the saved search represented by the given id. The authenticating user must be the owner of saved search ID being requested.

.PARAMETER id
    The ID of the saved search.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/manage-account-settings/api-reference/get-saved_searches-show-id

#>
    [CmdletBinding()]
    Param(
        [string]$id
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/saved_searches/show/:id'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/saved_searches/show/:id.json'

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
