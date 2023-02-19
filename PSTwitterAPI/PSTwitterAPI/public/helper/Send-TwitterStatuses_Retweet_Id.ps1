﻿function Send-TwitterStatuses_Retweet_Id {
<#
.SYNOPSIS
    Post, retrieve and engage with Tweets

.DESCRIPTION
    POST statuses/retweet/:id
    
    Retweets a tweet. Returns the original Tweet with Retweet details embedded.
    
    Usage Notes:
    
    This method is subject to update limits. A HTTP 403 will be returned if this limit as been hit.
    Twitter will ignore attempts to perform duplicate retweets.
    The retweet_count will be current as of when the payload is generated and may not reflect the exact count. It is intended as an approximation.

.PARAMETER id
    The numerical ID of the desired status.

.PARAMETER trim_user
    When set to either true , t or 1 , each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-retweet-id

#>
    [CmdletBinding()]
    Param(
        [string]$id,
        [string]$trim_user
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/statuses/retweet/:id'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/statuses/retweet/:id.json'

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
