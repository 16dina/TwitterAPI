﻿function Get-TwitterGeo_Search {
<#
.SYNOPSIS
    Get places near a location

.DESCRIPTION
    GET geo/search
    
    Search for places that can be attached to a Tweet via POST statuses/update. Given a latitude and a longitude pair, an IP address, or a name, this request will return a list of all the valid places that can be used as the place_id when updating a status.
    
    Conceptually, a query can be made from the user's location, retrieve a list of places, have the user validate the location they are at, and then send the ID of this location with a call to POST statuses/update.
    
    This is the recommended method to use find places that can be attached to statuses/update. Unlike GET geo/reverse_geocode which provides raw data access, this endpoint can potentially re-order places with regards to the user who is authenticated. This approach is also preferred for interactive place matching with the user.
    
    Some parameters in this method are only required based on the existence of other parameters. For instance, "lat" is required if "long" is provided, and vice-versa. Authentication is recommended, but not required with this method.

.PARAMETER lat
    The latitude to search around. This parameter will be ignored unless it is inside the range -90.0 to +90.0 (North is positive) inclusive. It will also be ignored if there isn't a corresponding long parameter.

.PARAMETER long
    The longitude to search around. The valid ranges for longitude are -180.0 to +180.0 (East is positive) inclusive. This parameter will be ignored if outside that range, if it is not a number, if geo_enabled is disabled, or if there not a corresponding lat parameter.

.PARAMETER query
    Free-form text to match against while executing a geo-based query, best suited for finding nearby locations by name. Remember to URL encode the query.

.PARAMETER ip
    An IP address. Used when attempting to fix geolocation based off of the user's IP address.

.PARAMETER granularity
    This is the minimal granularity of place types to return and must be one of: neighborhood , city , admin or country. If no granularity is provided for the request neighborhood is assumed.
Setting this to city, for example, will find places which have a type of city, admin or country.

.PARAMETER accuracy
    A hint on the "region" in which to search. If a number, then this is a radius in meters, but it can also take a string that is suffixed with ft to specify feet. If this is not passed in, then it is assumed to be 0m . If coming from a device, in practice, this value is whatever accuracy the device has measuring its location (whether it be coming from a GPS, WiFi triangulation, etc.).

.PARAMETER max_results
    A hint as to the number of results to return. This does not guarantee that the number of results returned will equal max_results, but instead informs how many "nearby" results to return. Ideally, only pass in the number of places you intend to display to the user here.

.PARAMETER contained_within
    This is the place_id which you would like to restrict the search results to. Setting this value means only places within the given place_id will be found.
Specify a place_id. For example, to scope all results to places within "San Francisco, CA USA", you would specify a place_id of "5a110d312052166f".

.PARAMETER attribute:street_address
    This parameter searches for places which have this given street address. There are other well-known, and application specific attributes available. Custom attributes are also permitted. Learn more about Place attributes.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/geo/places-near-location/api-reference/get-geo-search

#>
    [CmdletBinding()]
    Param(
        [string]$lat,
        [string]$long,
        [string]$query,
        [string]$ip,
        [string]$granularity,
        [string]$accuracy,
        [string]$max_results,
        [string]$contained_within,
        [string]$attribute:street_address
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/geo/search'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/geo/search.json'

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