{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.IAM.V2010_05_08.ListAccessKeys
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Returns information about the access key IDs associated with the specified
-- user. If there are none, the action returns an empty list. Although each
-- user is limited to a small number of keys, you can still paginate the
-- results using the MaxItems and Marker parameters. If the UserName field is
-- not specified, the UserName is determined implicitly based on the AWS
-- access key ID used to sign the request. Because this action works for
-- access keys under the AWS account, this API can be used to manage root
-- credentials even if the AWS account has no associated users. To ensure the
-- security of your AWS account, the secret access key is accessible only
-- during key and user creation. https://iam.amazonaws.com/
-- ?Action=ListAccessKeys &UserName=Bob &Version=2010-05-08 &AUTHPARAMS Bob
-- Bob AKIAIOSFODNN7EXAMPLE Active Bob AKIAI44QH8DHBEXAMPLE Inactive false
-- 7a62c49f-347e-4fc4-9331-6e8eEXAMPLE.
module Network.AWS.IAM.V2010_05_08.ListAccessKeys
    (
    -- * Request
      ListAccessKeys
    -- ** Request constructor
    , mkListAccessKeys
    -- ** Request lenses
    , lakUserName
    , lakMarker
    , lakMaxItems

    -- * Response
    , ListAccessKeysResponse
    -- ** Response lenses
    , lakrsAccessKeyMetadata
    , lakrsIsTruncated
    , lakrsMarker
    ) where

import Network.AWS.Request.Query
import Network.AWS.IAM.V2010_05_08.Types
import Network.AWS.Prelude

-- | 
data ListAccessKeys = ListAccessKeys
    { _lakUserName :: Maybe Text
    , _lakMarker :: Maybe Text
    , _lakMaxItems :: Maybe Integer
    } deriving (Show, Generic)

-- | Smart constructor for the minimum required parameters to construct
-- a valid 'ListAccessKeys' request.
mkListAccessKeys :: ListAccessKeys
mkListAccessKeys = ListAccessKeys
    { _lakUserName = Nothing
    , _lakMarker = Nothing
    , _lakMaxItems = Nothing
    }

-- | Name of the user.
lakUserName :: Lens' ListAccessKeys (Maybe Text)
lakUserName = lens _lakUserName (\s a -> s { _lakUserName = a })

-- | Use this parameter only when paginating results, and only in a subsequent
-- request after you've received a response where the results are truncated.
-- Set it to the value of the Marker element in the response you just
-- received.
lakMarker :: Lens' ListAccessKeys (Maybe Text)
lakMarker = lens _lakMarker (\s a -> s { _lakMarker = a })

-- | Use this parameter only when paginating results to indicate the maximum
-- number of keys you want in the response. If there are additional keys
-- beyond the maximum you specify, the IsTruncated response element is true.
-- This parameter is optional. If you do not include it, it defaults to 100.
lakMaxItems :: Lens' ListAccessKeys (Maybe Integer)
lakMaxItems = lens _lakMaxItems (\s a -> s { _lakMaxItems = a })

instance ToQuery ListAccessKeys where
    toQuery = genericQuery def

-- | Contains the result of a successful invocation of the ListAccessKeys
-- action.
data ListAccessKeysResponse = ListAccessKeysResponse
    { _lakrsAccessKeyMetadata :: [AccessKeyMetadata]
    , _lakrsIsTruncated :: Bool
    , _lakrsMarker :: Maybe Text
    } deriving (Show, Generic)

-- | A list of access key metadata.
lakrsAccessKeyMetadata :: Lens' ListAccessKeysResponse [AccessKeyMetadata]
lakrsAccessKeyMetadata =
    lens _lakrsAccessKeyMetadata (\s a -> s { _lakrsAccessKeyMetadata = a })

-- | A flag that indicates whether there are more keys to list. If your results
-- were truncated, you can make a subsequent pagination request using the
-- Marker request parameter to retrieve more keys in the list.
lakrsIsTruncated :: Lens' ListAccessKeysResponse Bool
lakrsIsTruncated =
    lens _lakrsIsTruncated (\s a -> s { _lakrsIsTruncated = a })

-- | If IsTruncated is true, this element is present and contains the value to
-- use for the Marker parameter in a subsequent pagination request.
lakrsMarker :: Lens' ListAccessKeysResponse (Maybe Text)
lakrsMarker = lens _lakrsMarker (\s a -> s { _lakrsMarker = a })

instance FromXML ListAccessKeysResponse where
    fromXMLOptions = xmlOptions

instance AWSRequest ListAccessKeys where
    type Sv ListAccessKeys = IAM
    type Rs ListAccessKeys = ListAccessKeysResponse

    request = post "ListAccessKeys"
    response _ = xmlResponse

instance AWSPager ListAccessKeys where
    next rq rs
        | not (rs ^. lakrsIsTruncated) = Nothing
        | otherwise = Just $
            rq & lakMarker .~ rs ^. lakrsMarker
