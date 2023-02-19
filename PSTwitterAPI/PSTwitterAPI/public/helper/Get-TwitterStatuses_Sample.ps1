﻿function Get-TwitterStatuses_Sample {
<#
.SYNOPSIS
    Sample realtime Tweets

.DESCRIPTION
    GET statuses/sample
    
    Returns a small random sample of all public statuses via a stream. The Tweets returned by the default access level are the same, so if two different clients connect to this endpoint, they will see the same Tweets.

.PARAMETER delimited
    Specifies whether messages should be length-delimited. See delimited or more information.

.PARAMETER stall_warnings
    Specifies whether stall warnings should be delivered. See stall_warnings for more information.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/tweets/sample-realtime/api-reference/get-statuses-sample

#>
    [CmdletBinding()]
    Param(
        [string]$delimited,
        [string]$stall_warnings
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/statuses/sample'
        [string]$ResourceUrl = 'https://stream.twitter.com/1.1/statuses/sample.json'

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