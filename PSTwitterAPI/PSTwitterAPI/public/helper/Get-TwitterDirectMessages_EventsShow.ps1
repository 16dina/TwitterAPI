﻿function Get-TwitterDirectMessages_EventsShow {
<#
.SYNOPSIS
    Sending and receiving events

.DESCRIPTION
    GET direct_messages/events/show
    
    Returns a single Direct Message event by the given id.

.PARAMETER id (required)
    

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/direct-messages/sending-and-receiving/api-reference/get-event

#>
    [CmdletBinding()]
    Param(
        [string]$id
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/direct_messages/events/show'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/direct_messages/events/show.json'

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
