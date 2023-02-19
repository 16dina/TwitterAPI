﻿function Send-TwitterBlocks_Create {
<#
.SYNOPSIS
    Mute, block and report users

.DESCRIPTION
    POST blocks/create
    
    Blocks the specified user from following the authenticating user. In addition the blocked user will not show in the authenticating users mentions or timeline (unless retweeted by another user). If a follow or friend relationship exists it is destroyed.
    
    The URL pattern /version/block/create/:screen_name_or_user_id.format is still accepted but not recommended. As a sequence of numbers is a valid screen name we recommend using the screen_name or user_id parameter instead.

.PARAMETER screen_name
    The screen name of the potentially blocked user. Helpful for disambiguating when a valid screen name is also a user ID.

.PARAMETER user_id
    The ID of the potentially blocked user. Helpful for disambiguating when a valid user ID is also a valid screen name.

.PARAMETER include_entities
    The entities node will not be included when set to false .

.PARAMETER skip_status
    When set to either true , t or 1 statuses will not be included in the returned user objects.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/mute-block-report-users/api-reference/post-blocks-create

#>
    [CmdletBinding()]
    Param(
        [string]$screen_name,
        [string]$user_id,
        [string]$include_entities,
        [string]$skip_status
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/blocks/create'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/blocks/create.json'

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
