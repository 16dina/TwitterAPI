﻿function Get-TwitterTrends_Place {
<#
.SYNOPSIS
    Get trends near a location

.DESCRIPTION
    GET trends/place
    
    Returns the top 50 trending topics for a specific WOEID, if trending information is available for it.
    
    The response is an array of trend objects that encode the name of the trending topic, the query parameter that can be used to search for the topic on Twitter Search, and the Twitter Search URL.
    
    This information is cached for 5 minutes. Requesting more frequently than that will not return any more data, and will count against rate limit usage.
    
    The tweet_volume for the last 24 hours is also returned for many trends if this is available.

.PARAMETER id
    The Yahoo! Where On Earth ID of the location to return trending information for. Global information is available by using 1 as the WOEID .

.PARAMETER exclude
    Setting this equal to hashtags will remove all hashtags from the trends list.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/trends/trends-for-location/api-reference/get-trends-place

#>
    [CmdletBinding()]
    Param(
        [string]$id,
        [string]$exclude
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/trends/place'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/trends/place.json'

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
