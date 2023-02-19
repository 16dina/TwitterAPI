﻿function Get-TwitterDirectMessages_WelcomeMessagesRulesList {
<#
.SYNOPSIS
    Welcome Messages

.DESCRIPTION
    GET direct_messages/welcome_messages/rules/list
    
    Returns a list of Welcome Message Rules.

.PARAMETER count (optional)
    

.PARAMETER cursor (optional)
    

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/direct-messages/welcome-messages/api-reference/list-welcome-message-rules

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
        [string]$Resource    = '/direct_messages/welcome_messages/rules/list'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/direct_messages/welcome_messages/rules/list.json'

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