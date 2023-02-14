// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'dart:async';
// import 'dart:io';

import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;

Future<void> tweeting(String value) async {
  //! You need to get keys and tokens at https://developer.twitter.com
  final twitter = v2.TwitterApi(
    //! Authentication with OAuth2.0 is the default.
    //!
    //! Note that to use endpoints that require certain user permissions,
    //! such as Tweets and Likes, you need a token issued by OAuth2.0 PKCE.
    //!
    //! The easiest way to achieve authentication with OAuth 2.0 PKCE is
    //! to use [twitter_oauth2_pkce](https://pub.dev/packages/twitter_oauth2_pkce)!
    bearerToken: 'YOUR_TOKEN_HERE',

    //! Or perhaps you would prefer to use the good old OAuth1.0a method
    //! over the OAuth2.0 PKCE method. Then you can use the following code
    //! to set the OAuth1.0a tokens.
    //!
    //! However, note that some endpoints cannot be used for OAuth 1.0a method
    //! authentication.
    oauthTokens: v2.OAuthTokens(
      consumerKey: 'YOUR_CONSUMER_KEY_HERE',
      consumerSecret: 'YOUR_CONSUMER_SECRET_HERE',
      accessToken: 'YOUR_ACCESS_TOKEN_HERE',
      accessTokenSecret: 'YOUR_ACCESS_TOKEN_SECRET_HERE',
    ),

    //! Automatic retry is available when network error or server error
    //! are happened.
    retryConfig: v2.RetryConfig(
      maxAttempts: 5,
      onExecute: (event) => print(
        'Retry after ${event.intervalInSeconds} seconds... '
        '[${event.retryCount} times]',
      ),
    ),

    //! The default timeout is 10 seconds.
    timeout: Duration(seconds: 20),
  );

  try {
    //! Get the authenticated user's profile.
    final me = await twitter.users.lookupMe();

    /* GET only my 10 last tweets */
    // final tweets =
    //     twitter.tweets.lookupTweets(userId: me.data.id, maxResults: 10);

    // //! Get the tweets associated with the search query.
    // final tweets = await twitter.tweets.searchRecent(
    //   query: '#ElonMusk',
    //   maxResults: 20,
    //   // You can expand the search result.
    //   expansions: [
    //     v2.TweetExpansion.authorId,
    //     v2.TweetExpansion.inReplyToUserId,
    //   ],
    //   tweetFields: [
    //     v2.TweetField.conversationId,
    //     v2.TweetField.publicMetrics,
    //     v2.TweetField.editControls,
    //   ],
    //   userFields: [
    //     v2.UserField.location,
    //     v2.UserField.verified,
    //     v2.UserField.verifiedType,
    //     v2.UserField.entities,
    //     v2.UserField.publicMetrics,
    //   ],

    //   //! Safe paging is easy to implement.
    //   paging: (event) {
    //     print(event.response);

    //     if (event.count == 3) {
    //       return v2.ForwardPaginationControl.stop();
    //     }

    //     return v2.ForwardPaginationControl.next();
    //   },
    // );

    // //! You can serialize & deserialize JSON from response object
    // //! and model object.
    // final tweetJson = tweets.data.first.toJson();
    // final tweet = v2.TweetData.fromJson(tweetJson);
    // print(tweet);

    // await twitter.tweets.createLike(
    //   userId: me.data.id,
    //   tweetId: tweets.data.first.id,
    // );

    // //! You can upload media such as image, gif and video.
    // final uploadedMedia = await twitter.media.uploadMedia(
    //   file: File.fromUri(Uri.file('FILE_PATH')),
    //   altText: 'This is alt text.',

    //   //! You can check the upload progress.
    //   onProgress: (event) {
    //     switch (event.state) {
    //       case v2.UploadState.preparing:
    //         print('Upload is preparing...');
    //         break;
    //       case v2.UploadState.inProgress:
    //         print('${event.progress}% completed...');
    //         break;
    //       case v2.UploadState.completed:
    //         print('Upload has completed!');
    //         break;
    //     }
    //   },
    //   onFailed: (error) => print('Upload failed due to "${error.message}"'),
    // );

    //! You can easily post a tweet with the uploaded media.
    await twitter.tweets.createTweet(
      text: value,
      // media: v2.TweetMediaParam(
      //   mediaIds: [uploadedMedia.data.id],
      // ),
    );

    //! High-performance Volume Stream endpoint is available.
    // final sampleStream = await twitter.tweets.connectSampleStream();
    // await for (final response in sampleStream.stream.handleError(print)) {
    //   print(response);
    // }

    // //! Also high-performance Filtered Stream endpoint is available.
    // await twitter.tweets.createFilteringRules(
    //   rules: [
    //     v2.FilteringRuleParam(value: '#ElonMusk'),

    //     //! You can easily build filtering rule using by "FilteringRule" object.
    //     v2.FilteringRuleParam(
    //       //! => #Tesla has:media
    //       value: v2.FilteringRule.of()
    //           .matchHashtag('Tesla')
    //           .and()
    //           .matchTweetContainsMedia()
    //           .build(),
    //     ),
    //     v2.FilteringRuleParam(
    //       //! => (#SpaceX has:media) OR (#SpaceX has:hashtags) sample:50
    //       value: v2.FilteringRule.ofSample(percent: 50)
    //           .group(
    //             v2.FilteringRule.of()
    //                 .matchHashtag('SpaceX')
    //                 .and()
    //                 .matchTweetContainsMedia(),
    //           )
    //           .or()
    //           .group(
    //             v2.FilteringRule.of()
    //                 .matchHashtag('SpaceX')
    //                 .and()
    //                 .matchTweetContainsHashtags(),
    //           )
    //           .build(),
    //     ),
    //   ],
    // );

    final filteredStream = await twitter.tweets.connectFilteredStream();
    await for (final response in filteredStream.stream.handleError(print)) {
      print(response.data);
      print(response.matchingRules);
    }
  } on TimeoutException catch (e) {
    print(e);
  } on v2.UnauthorizedException catch (e) {
    print(e);
  } on v2.RateLimitExceededException catch (e) {
    print(e);
  } on v2.DataNotFoundException catch (e) {
    print(e);
  } on v2.TwitterUploadException catch (e) {
    print(e);
  } on v2.TwitterException catch (e) {
    print(e.response.headers);
    print(e.body);
    print(e);
  }
}
