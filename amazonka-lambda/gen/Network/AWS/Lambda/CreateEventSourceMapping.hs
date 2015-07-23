{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.Lambda.CreateEventSourceMapping
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Identifies a stream as an event source for a Lambda function. It can be
-- either an Amazon Kinesis stream or an Amazon DynamoDB stream. AWS Lambda
-- invokes the specified function when records are posted to the stream.
--
-- This is the pull model, where AWS Lambda invokes the function. For more
-- information, go to
-- <http://docs.aws.amazon.com/lambda/latest/dg/lambda-introduction.html AWS Lambda: How it Works>
-- in the /AWS Lambda Developer Guide/.
--
-- This association between an Amazon Kinesis stream and a Lambda function
-- is called the event source mapping. You provide the configuration
-- information (for example, which stream to read from and which Lambda
-- function to invoke) for the event source mapping in the request body.
--
-- Each event source, such as an Amazon Kinesis or a DynamoDB stream, can
-- be associated with multiple AWS Lambda function. A given Lambda function
-- can be associated with multiple AWS event sources.
--
-- This operation requires permission for the
-- @lambda:CreateEventSourceMapping@ action.
--
-- <http://docs.aws.amazon.com/lambda/latest/dg/API_CreateEventSourceMapping.html>
module Network.AWS.Lambda.CreateEventSourceMapping
    (
    -- * Request
      CreateEventSourceMapping
    -- ** Request constructor
    , createEventSourceMapping
    -- ** Request lenses
    , cesmrqEnabled
    , cesmrqBatchSize
    , cesmrqEventSourceARN
    , cesmrqFunctionName
    , cesmrqStartingPosition

    -- * Response
    , EventSourceMappingConfiguration
    -- ** Response constructor
    , eventSourceMappingConfiguration
    -- ** Response lenses
    , esmcEventSourceARN
    , esmcFunctionARN
    , esmcState
    , esmcUUId
    , esmcLastProcessingResult
    , esmcBatchSize
    , esmcStateTransitionReason
    , esmcLastModified
    ) where

import           Network.AWS.Lambda.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'createEventSourceMapping' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cesmrqEnabled'
--
-- * 'cesmrqBatchSize'
--
-- * 'cesmrqEventSourceARN'
--
-- * 'cesmrqFunctionName'
--
-- * 'cesmrqStartingPosition'
data CreateEventSourceMapping = CreateEventSourceMapping'
    { _cesmrqEnabled          :: !(Maybe Bool)
    , _cesmrqBatchSize        :: !(Maybe Nat)
    , _cesmrqEventSourceARN   :: !Text
    , _cesmrqFunctionName     :: !Text
    , _cesmrqStartingPosition :: !EventSourcePosition
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'CreateEventSourceMapping' smart constructor.
createEventSourceMapping :: Text -> Text -> EventSourcePosition -> CreateEventSourceMapping
createEventSourceMapping pEventSourceARN_ pFunctionName_ pStartingPosition_ =
    CreateEventSourceMapping'
    { _cesmrqEnabled = Nothing
    , _cesmrqBatchSize = Nothing
    , _cesmrqEventSourceARN = pEventSourceARN_
    , _cesmrqFunctionName = pFunctionName_
    , _cesmrqStartingPosition = pStartingPosition_
    }

-- | Indicates whether AWS Lambda should begin polling the event source, the
-- default is not enabled.
cesmrqEnabled :: Lens' CreateEventSourceMapping (Maybe Bool)
cesmrqEnabled = lens _cesmrqEnabled (\ s a -> s{_cesmrqEnabled = a});

-- | The largest number of records that AWS Lambda will retrieve from your
-- event source at the time of invoking your function. Your function
-- receives an event with all the retrieved records. The default is 100
-- records.
cesmrqBatchSize :: Lens' CreateEventSourceMapping (Maybe Natural)
cesmrqBatchSize = lens _cesmrqBatchSize (\ s a -> s{_cesmrqBatchSize = a}) . mapping _Nat;

-- | The Amazon Resource Name (ARN) of the Amazon Kinesis or the Amazon
-- DynamoDB stream that is the event source. Any record added to this
-- stream could cause AWS Lambda to invoke your Lambda function, it depends
-- on the @BatchSize@. AWS Lambda POSTs the Amazon Kinesis event,
-- containing records, to your Lambda function as JSON.
cesmrqEventSourceARN :: Lens' CreateEventSourceMapping Text
cesmrqEventSourceARN = lens _cesmrqEventSourceARN (\ s a -> s{_cesmrqEventSourceARN = a});

-- | The Lambda function to invoke when AWS Lambda detects an event on the
-- stream.
--
-- You can specify an unqualified function name (for example,
-- \"Thumbnail\") or you can specify Amazon Resource Name (ARN) of the
-- function (for example,
-- \"arn:aws:lambda:us-west-2:account-id:function:ThumbNail\"). AWS Lambda
-- also allows you to specify only the account ID qualifier (for example,
-- \"account-id:Thumbnail\"). Note that the length constraint applies only
-- to the ARN. If you specify only the function name, it is limited to 64
-- character in length.
cesmrqFunctionName :: Lens' CreateEventSourceMapping Text
cesmrqFunctionName = lens _cesmrqFunctionName (\ s a -> s{_cesmrqFunctionName = a});

-- | The position in the stream where AWS Lambda should start reading. For
-- more information, go to
-- <http://docs.aws.amazon.com/kinesis/latest/APIReference/API_GetShardIterator.html#Kinesis-GetShardIterator-request-ShardIteratorType ShardIteratorType>
-- in the /Amazon Kinesis API Reference/.
cesmrqStartingPosition :: Lens' CreateEventSourceMapping EventSourcePosition
cesmrqStartingPosition = lens _cesmrqStartingPosition (\ s a -> s{_cesmrqStartingPosition = a});

instance AWSRequest CreateEventSourceMapping where
        type Sv CreateEventSourceMapping = Lambda
        type Rs CreateEventSourceMapping =
             EventSourceMappingConfiguration
        request = postJSON
        response = receiveJSON (\ s h x -> eitherParseJSON x)

instance ToHeaders CreateEventSourceMapping where
        toHeaders = const mempty

instance ToJSON CreateEventSourceMapping where
        toJSON CreateEventSourceMapping'{..}
          = object
              ["Enabled" .= _cesmrqEnabled,
               "BatchSize" .= _cesmrqBatchSize,
               "EventSourceArn" .= _cesmrqEventSourceARN,
               "FunctionName" .= _cesmrqFunctionName,
               "StartingPosition" .= _cesmrqStartingPosition]

instance ToPath CreateEventSourceMapping where
        toPath = const "/2015-03-31/event-source-mappings/"

instance ToQuery CreateEventSourceMapping where
        toQuery = const mempty