﻿function Send-TwitterCollections_Create {
<#
.SYNOPSIS
    Curate a collection of Tweets

.DESCRIPTION
    POST collections/create
    
    Create a Collection owned by the currently authenticated user.
    
    The API endpoint may refuse to complete the request if the authenticated user has exceeded the total number of allowed collections for their account.

.PARAMETER description
    A brief description of this collection in 160 characters or fewer.

.PARAMETER url
    A fully-qualified URL to associate with this collection.

.PARAMETER timeline_order
    Order Tweets chronologically or in the order they are added to a Collection. curation_reverse_chron - order added (default) tweet_chron - oldest first tweet_reverse_chron - most recent first

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/tweets/curate-a-collection/api-reference/post-collections-create

#>
    [CmdletBinding()]
    Param(
        [string]$description,
        [string]$url,
        [string]$timeline_order
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/collections/create'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/collections/create.json'

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
