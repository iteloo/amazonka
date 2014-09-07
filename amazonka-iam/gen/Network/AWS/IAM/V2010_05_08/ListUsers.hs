{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.IAM.V2010_05_08.ListUsers
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Lists the users that have the specified path prefix. If there are none, the
-- action returns an empty list. You can paginate the results using the
-- MaxItems and Marker parameters. https://iam.amazonaws.com/
-- ?Action=ListUsers
-- &PathPrefix=/division_abc/subdivision_xyz/product_1234/engineering/
-- &Version=2010-05-08 &AUTHPARAMS /division_abc/subdivision_xyz/engineering/
-- Andrew AID2MAB8DPLSRHEXAMPLE arn:aws:iam::123456789012:user
-- /division_abc/subdivision_xyz/engineering/Andrew
-- /division_abc/subdivision_xyz/engineering/ Jackie AIDIODR4TAW7CSEXAMPLE
-- arn:aws:iam::123456789012:user
-- /division_abc/subdivision_xyz/engineering/Jackie false
-- 7a62c49f-347e-4fc4-9331-6e8eEXAMPLE.
module Network.AWS.IAM.V2010_05_08.ListUsers
    (
    -- * Request
      ListUsers
    -- ** Request constructor
    , mkListUsers
    -- ** Request lenses
    , luPathPrefix
    , luMarker
    , luMaxItems

    -- * Response
    , ListUsersResponse
    -- ** Response lenses
    , lursUsers
    , lursIsTruncated
    , lursMarker
    ) where

import Network.AWS.Request.Query
import Network.AWS.IAM.V2010_05_08.Types
import Network.AWS.Prelude

-- | 
data ListUsers = ListUsers
    { _luPathPrefix :: Maybe Text
    , _luMarker :: Maybe Text
    , _luMaxItems :: Maybe Integer
    } deriving (Show, Generic)

-- | Smart constructor for the minimum required parameters to construct
-- a valid 'ListUsers' request.
mkListUsers :: ListUsers
mkListUsers = ListUsers
    { _luPathPrefix = Nothing
    , _luMarker = Nothing
    , _luMaxItems = Nothing
    }

-- | The path prefix for filtering the results. For example:
-- /division_abc/subdivision_xyz/, which would get all user names whose path
-- starts with /division_abc/subdivision_xyz/. This parameter is optional. If
-- it is not included, it defaults to a slash (/), listing all user names.
luPathPrefix :: Lens' ListUsers (Maybe Text)
luPathPrefix = lens _luPathPrefix (\s a -> s { _luPathPrefix = a })

-- | Use this parameter only when paginating results, and only in a subsequent
-- request after you've received a response where the results are truncated.
-- Set it to the value of the Marker element in the response you just
-- received.
luMarker :: Lens' ListUsers (Maybe Text)
luMarker = lens _luMarker (\s a -> s { _luMarker = a })

-- | Use this parameter only when paginating results to indicate the maximum
-- number of user names you want in the response. If there are additional user
-- names beyond the maximum you specify, the IsTruncated response element is
-- true. This parameter is optional. If you do not include it, it defaults to
-- 100.
luMaxItems :: Lens' ListUsers (Maybe Integer)
luMaxItems = lens _luMaxItems (\s a -> s { _luMaxItems = a })

instance ToQuery ListUsers where
    toQuery = genericQuery def

-- | Contains the result of a successful invocation of the ListUsers action.
data ListUsersResponse = ListUsersResponse
    { _lursUsers :: [User]
    , _lursIsTruncated :: Bool
    , _lursMarker :: Maybe Text
    } deriving (Show, Generic)

-- | A list of users.
lursUsers :: Lens' ListUsersResponse [User]
lursUsers = lens _lursUsers (\s a -> s { _lursUsers = a })

-- | A flag that indicates whether there are more user names to list. If your
-- results were truncated, you can make a subsequent pagination request using
-- the Marker request parameter to retrieve more users in the list.
lursIsTruncated :: Lens' ListUsersResponse Bool
lursIsTruncated = lens _lursIsTruncated (\s a -> s { _lursIsTruncated = a })

-- | If IsTruncated is true, this element is present and contains the value to
-- use for the Marker parameter in a subsequent pagination request.
lursMarker :: Lens' ListUsersResponse (Maybe Text)
lursMarker = lens _lursMarker (\s a -> s { _lursMarker = a })

instance FromXML ListUsersResponse where
    fromXMLOptions = xmlOptions

instance AWSRequest ListUsers where
    type Sv ListUsers = IAM
    type Rs ListUsers = ListUsersResponse

    request = post "ListUsers"
    response _ = xmlResponse

instance AWSPager ListUsers where
    next rq rs
        | not (rs ^. lursIsTruncated) = Nothing
        | otherwise = Just $
            rq & luMarker .~ rs ^. lursMarker
