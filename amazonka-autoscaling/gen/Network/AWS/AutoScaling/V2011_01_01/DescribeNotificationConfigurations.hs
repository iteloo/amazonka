{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.AutoScaling.V2011_01_01.DescribeNotificationConfigurations
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Returns a list of notification actions associated with Auto Scaling groups
-- for specified events.
module Network.AWS.AutoScaling.V2011_01_01.DescribeNotificationConfigurations
    (
    -- * Request
      DescribeNotificationConfigurations
    -- ** Request constructor
    , mkDescribeNotificationConfigurations
    -- ** Request lenses
    , dnc1AutoScalingGroupNames
    , dnc1NextToken
    , dnc1MaxRecords

    -- * Response
    , DescribeNotificationConfigurationsResponse
    -- ** Response lenses
    , dncrsNotificationConfigurations
    , dncrsNextToken
    ) where

import Network.AWS.Request.Query
import Network.AWS.AutoScaling.V2011_01_01.Types
import Network.AWS.Prelude

-- | 
data DescribeNotificationConfigurations = DescribeNotificationConfigurations
    { _dnc1AutoScalingGroupNames :: [Text]
    , _dnc1NextToken :: Maybe Text
    , _dnc1MaxRecords :: Maybe Integer
    } deriving (Show, Generic)

-- | Smart constructor for the minimum required parameters to construct
-- a valid 'DescribeNotificationConfigurations' request.
mkDescribeNotificationConfigurations :: DescribeNotificationConfigurations
mkDescribeNotificationConfigurations = DescribeNotificationConfigurations
    { _dnc1AutoScalingGroupNames = mempty
    , _dnc1NextToken = Nothing
    , _dnc1MaxRecords = Nothing
    }

-- | The name of the Auto Scaling group.
dnc1AutoScalingGroupNames :: Lens' DescribeNotificationConfigurations [Text]
dnc1AutoScalingGroupNames =
    lens _dnc1AutoScalingGroupNames
         (\s a -> s { _dnc1AutoScalingGroupNames = a })

-- | A string that is used to mark the start of the next batch of returned
-- results for pagination.
dnc1NextToken :: Lens' DescribeNotificationConfigurations (Maybe Text)
dnc1NextToken = lens _dnc1NextToken (\s a -> s { _dnc1NextToken = a })

-- | Maximum number of records to be returned.
dnc1MaxRecords :: Lens' DescribeNotificationConfigurations (Maybe Integer)
dnc1MaxRecords = lens _dnc1MaxRecords (\s a -> s { _dnc1MaxRecords = a })

instance ToQuery DescribeNotificationConfigurations where
    toQuery = genericQuery def

-- | The output of the DescribeNotificationConfigurations action.
data DescribeNotificationConfigurationsResponse = DescribeNotificationConfigurationsResponse
    { _dncrsNotificationConfigurations :: [NotificationConfiguration]
    , _dncrsNextToken :: Maybe Text
    } deriving (Show, Generic)

-- | The list of notification configurations.
dncrsNotificationConfigurations :: Lens' DescribeNotificationConfigurationsResponse [NotificationConfiguration]
dncrsNotificationConfigurations =
    lens _dncrsNotificationConfigurations
         (\s a -> s { _dncrsNotificationConfigurations = a })

-- | A string that is used to mark the start of the next batch of returned
-- results for pagination.
dncrsNextToken :: Lens' DescribeNotificationConfigurationsResponse (Maybe Text)
dncrsNextToken = lens _dncrsNextToken (\s a -> s { _dncrsNextToken = a })

instance FromXML DescribeNotificationConfigurationsResponse where
    fromXMLOptions = xmlOptions

instance AWSRequest DescribeNotificationConfigurations where
    type Sv DescribeNotificationConfigurations = AutoScaling
    type Rs DescribeNotificationConfigurations = DescribeNotificationConfigurationsResponse

    request = post "DescribeNotificationConfigurations"
    response _ = xmlResponse

instance AWSPager DescribeNotificationConfigurations where
    next rq rs = (\x -> rq & dnc1NextToken ?~ x)
        <$> (rs ^. dncrsNextToken)
