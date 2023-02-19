﻿function Send-TwitterOauth_RequestToken {
<#
.SYNOPSIS
    Authentication

.DESCRIPTION
    POST oauth/request_token
    
    Allows a Consumer application to obtain an OAuth Request Token to request user authorization. This method fulfills Section 6.1 of the OAuth 1.0 authentication flow.
    
    We require you use HTTPS for all OAuth authorization steps.
    
    Usage Note: Only ASCII values are accepted for the oauth_nonce

.PARAMETER oauth_callback
    For OAuth 1.0a compliance this parameter is required . The value you specify here will be used as the URL a user is redirected to should they approve your application's access to their account. Set this to oob for out-of-band pin mode. This is also how you specify custom callbacks for use in desktop/mobile applications. Always send an oauth_callback on this step, regardless of a pre-registered callback.
We require that any callback URL used with this endpoint will have to be whitelisted within the app settings on developer.twitter.com*

.PARAMETER x_auth_access_type
    Overrides the access level an application requests to a users account. Supported values are read or write . This parameter is intended to allow a developer to register a read/write application but also request read only access when appropriate.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/basics/authentication/api-reference/request_token

#>
    [CmdletBinding()]
    Param(
        [string]$oauth_callback,
        [string]$x_auth_access_type
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/oauth/request_token'
        [string]$ResourceUrl = 'https://api.twitter.com/oauth/request_token'

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
