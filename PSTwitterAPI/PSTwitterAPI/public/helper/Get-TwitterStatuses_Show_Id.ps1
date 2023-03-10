function Get-TwitterStatuses_Show_Id {
<#
.SYNOPSIS
    Post, retrieve and engage with Tweets

.DESCRIPTION
    GET statuses/show/:id
    
    Returns a single Tweet, specified by the id parameter. The Tweet's author will also be embedded within the Tweet.
    
    See GET statuses / lookup for getting Tweets in bulk (up to 100 per call). See also Embedded Timelines, Embedded Tweets, and GET statuses/oembed for tools to render Tweets according to Display Requirements.
    
    About Geo
    
    If there is no geotag for a status, then there will be an empty <geo></geo> or "geo" : {}. This can only be populated if the user has used the Geotagging API to send a statuses/update.
    
    The JSON response mostly uses conventions laid out in GeoJSON. The coordinates that Twitter renders are reversed from the GeoJSON specification (GeoJSON specifies a longitude then a latitude, whereas Twitter represents it as a latitude then a longitude), eg: "geo": { "type":"Point", "coordinates":[37.78029, -122.39697] }

.PARAMETER id
    The numerical ID of the desired Tweet.

.PARAMETER trim_user
    When set to either true , t or 1 , each Tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.

.PARAMETER include_my_retweet
    When set to either true , t or 1 , any Tweets returned that have been retweeted by the authenticating user will include an additional current_user_retweet node, containing the ID of the source status for the retweet.

.PARAMETER include_entities
    The entities node will not be included when set to false.

.PARAMETER include_ext_alt_text
    If alt text has been added to any attached media entities, this parameter will return an ext_alt_text value in the top-level key for the media entity. If no value has been set, this will be returned as null

.PARAMETER include_card_uri
    When set to either true , t or 1 , the retrieved Tweet will include a card_uri attribute when there is an ads card attached to the Tweet and when that card was attached using the card_uri value.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-statuses-show-id

#>
    [CmdletBinding()]
    Param(
        [string]$id,
        [string]$trim_user,
        [string]$include_my_retweet,
        [string]$include_entities,
        [string]$include_ext_alt_text,
        [string]$include_card_uri
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/statuses/show/:id'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/statuses/show.json'

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
