﻿function Get-TwitterStatuses_RetweetersIds {
<#
.SYNOPSIS
    Post, retrieve and engage with Tweets

.DESCRIPTION
    GET statuses/retweeters/ids
    
    Returns a collection of up to 100 user IDs belonging to users who have retweeted the Tweet specified by the id parameter.
    
    This method offers similar data to GET statuses / retweets / :id.

.PARAMETER id
    The numerical ID of the desired status.

.PARAMETER count
    Specifies the number of records to retrieve. Must be less than or equal to 100.

.PARAMETER cursor
    Causes the list of IDs to be broken into pages of no more than 100 IDs at a time. The number of IDs returned is not guaranteed to be 100 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first "page."
The response from the API will include a previous_cursor and next_cursor to allow paging back and forth. See our cursor docs for more information.
While this method supports the cursor parameter, the entire result set can be returned in a single cursored collection. Using the count parameter with this method will not provide segmented cursors for use with this parameter.

.PARAMETER stringify_ids
    Many programming environments will not consume Tweet ids due to their size. Provide this option to have ids returned as strings instead.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-statuses-retweeters-ids

#>
    [CmdletBinding()]
    Param(
        [string]$id,
        [string]$count,
        [string]$cursor,
        [string]$stringify_ids
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/statuses/retweeters/ids'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/statuses/retweeters/ids.json'

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
