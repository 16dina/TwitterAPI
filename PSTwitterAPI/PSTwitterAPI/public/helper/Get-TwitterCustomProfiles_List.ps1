﻿function Get-TwitterCustomProfiles_List {
<#
.SYNOPSIS
    Custom profiles

.DESCRIPTION
    GET custom_profiles/list
    
    Retrieves all custom profiles for the authenticated account. Default page size is 20.

.PARAMETER count (optional)
    

.PARAMETER cursor (optional)
    

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/direct-messages/custom-profiles/api-reference/get-profile-list

#>
    [CmdletBinding()]
    Param(
        [string]$count,
        [string]$cursor
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/custom_profiles/list'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/custom_profiles/list.json'

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