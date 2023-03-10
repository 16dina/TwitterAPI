function Send-TwitterStatuses_Update {
<#
.SYNOPSIS
    Post, retrieve and engage with Tweets

.DESCRIPTION
    POST statuses/update
    
    Updates the authenticating user's current status, also known as Tweeting.
    
    For each update attempt, the update text is compared with the authenticating user's recent Tweets. Any attempt that would result in duplication will be blocked, resulting in a 403 error. A user cannot submit the same status twice in a row.
    
    While not rate limited by the API, a user is limited in the number of Tweets they can create at a time. If the number of updates posted by the user reaches the current allowed limit this method will return an HTTP 403 error.
    
    About Geo
    
    Any geo-tagging parameters in the update will be ignored if geo_enabled for the user is false (this is the default setting for all users, unless the user has enabled geolocation in their settings)
    The number of digits after the decimal separator passed to lat (up to 8) is tracked so that when the lat is returned in a status object it will have the same number of digits after the decimal separator.
    Use a decimal point as the separator (and not a decimal comma) for the latitude and the longitude - usage of a decimal comma will cause the geo-tagged portion of the status update to be dropped.
    For JSON, the response mostly uses conventions described in GeoJSON. However, the geo object coordinates that Twitter renders are reversed from the GeoJSON specification. GeoJSON specifies a longitude then a latitude, whereas Twitter represents it as a latitude then a longitude: "geo": { "type":"Point", "coordinates":[37.78217, -122.40062] }
    The coordinates object is replacing the geo object (no deprecation date has been set for the geo object yet) -- the difference is that the coordinates object, in JSON, is now rendered correctly in GeoJSON.
    If a place_id is passed into the status update, then that place will be attached to the status. If no place_id was explicitly provided, but latitude and longitude are, the API attempts to implicitly provide a place by calling geo/reverse_geocode.
    Users have the ability to remove all geotags from all their Tweets en masse via the user settings page. Currently there is no method to remove geotags from individual Tweets.

.PARAMETER status
    The text of the status update. URL encode as necessary. t.co link wrapping will affect character counts.

.PARAMETER in_reply_to_status_id
    The ID of an existing status that the update is in reply to. Note: This parameter will be ignored unless the author of the Tweet this parameter references is mentioned within the status text. Therefore, you must include @username , where username is the author of the referenced Tweet, within the update.

.PARAMETER auto_populate_reply_metadata
    If set to true and used with in_reply_to_status_id, leading @mentions will be looked up from the original Tweet, and added to the new Tweet from there. This wil append @mentions into the metadata of an extended Tweet as a reply chain grows, until the limit on @mentions is reached. In cases where the original Tweet has been deleted, the reply will fail.

.PARAMETER exclude_reply_user_ids
    When used with auto_populate_reply_metadata, a comma-separated list of user ids which will be removed from the server-generated @mentions prefix on an extended Tweet. Note that the leading @mention cannot be removed as it would break the in-reply-to-status-id semantics. Attempting to remove it will be silently ignored.

.PARAMETER attachment_url
    In order for a URL to not be counted in the status body of an extended Tweet, provide a URL as a Tweet attachment. This URL must be a Tweet permalink, or Direct Message deep link. Arbitrary, non-Twitter URLs must remain in the status text. URLs passed to the attachment_url parameter not matching either a Tweet permalink or Direct Message deep link will fail at Tweet creation and cause an exception.

.PARAMETER media_ids
    A comma-delimited list of media_ids to associate with the Tweet. You may include up to 4 photos or 1 animated GIF or 1 video in a Tweet. See Uploading Media for further details on uploading media.

.PARAMETER possibly_sensitive
    If you upload Tweet media that might be considered sensitive content such as nudity, or medical procedures, you must set this value to true. See Media setting and best practices for more context.

.PARAMETER lat
    The latitude of the location this Tweet refers to. This parameter will be ignored unless it is inside the range -90.0 to +90.0 (North is positive) inclusive. It will also be ignored if there is no corresponding long parameter.

.PARAMETER long
    The longitude of the location this Tweet refers to. The valid ranges for longitude are -180.0 to +180.0 (East is positive) inclusive. This parameter will be ignored if outside that range, if it is not a number, if geo_enabled is disabled, or if there no corresponding lat parameter.

.PARAMETER place_id
    A place in the world.

.PARAMETER display_coordinates
    Whether or not to put a pin on the exact coordinates a Tweet has been sent from.

.PARAMETER trim_user
    When set to either true , t or 1 , the response will include a user object including only the author's ID. Omit this parameter to receive the complete user object.

.PARAMETER enable_dmcommands
    When set to true, enables shortcode commands for sending Direct Messages as part of the status text to send a Direct Message to a user. When set to false, disables this behavior and includes any leading characters in the status text that is posted

.PARAMETER fail_dmcommands
    When set to true, causes any status text that starts with shortcode commands to return an API error. When set to false, allows shortcode commands to be sent in the status text and acted on by the API.

.PARAMETER card_uri
    Associate an ads card with the Tweet using the card_uri value from any ads card response.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-update

#>
    [CmdletBinding()]
    Param(
        [string]$status,
        [string]$in_reply_to_status_id,
        [string]$auto_populate_reply_metadata,
        [string]$exclude_reply_user_ids,
        [string]$attachment_url,
        [string]$media_ids,
        [string]$possibly_sensitive,
        [string]$lat,
        [string]$long,
        [string]$place_id,
        [string]$display_coordinates,
        [string]$trim_user,
        [string]$enable_dmcommands,
        [string]$fail_dmcommands,
        [string]$card_uri
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/statuses/update'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/statuses/update.json'

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
