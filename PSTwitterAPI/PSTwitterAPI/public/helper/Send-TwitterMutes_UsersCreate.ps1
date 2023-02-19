﻿function Send-TwitterMutes_UsersCreate {
<#
.SYNOPSIS
    Mute, block and report users

.DESCRIPTION
    POST mutes/users/create
    
    Mutes the user specified in the ID parameter for the authenticating user.
    
    Returns the muted user when successful. Returns a string describing the failure condition when unsuccessful.
    
    Actions taken in this method are asynchronous. Changes will be eventually consistent.

.PARAMETER screen_name
    The screen name of the potentially muted user. Helpful for disambiguating when a valid screen name is also a user ID.

.PARAMETER user_id
    The ID of the potentially muted user. Helpful for disambiguating when a valid user ID is also a valid screen name.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/mute-block-report-users/api-reference/post-mutes-users-create

#>
    [CmdletBinding()]
    Param(
        [string]$screen_name,
        [string]$user_id
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/mutes/users/create'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/mutes/users/create.json'

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
