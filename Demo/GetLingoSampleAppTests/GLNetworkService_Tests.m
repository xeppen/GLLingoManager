//
//  GLNetworkService_Tests.m
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 16/02/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLNetworkService.h"
#import <OCMock/OCMock.h>

@interface GLNetworkService_Tests : XCTestCase

@end

@implementation GLNetworkService_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testSampleFetchOfTranslations {
    XCTestExpectation *fetchCompletionExpectation =
    [self expectationWithDescription:@"Successfully fetched translations!"];
    
    // Mock Session
    // Creates an NSURLSession instance that shall be used in the service.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    id myMockedURLSession = OCMPartialMock(session);
    
    OCMStub([myMockedURLSession dataTaskWithRequest:[OCMArg any] completionHandler:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        
        __block void (^completion)(NSData *data, NSURLResponse *response, NSError *error);
        
        // Get second argument
        [invocation getArgument:&completion atIndex:3];
        NSData *testData = GetFileData(@"sampleFetchTranslationsSV", @"json");
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            completion(testData, nil, nil);
        });
    });
    
    // Mock class
    // Mocking the class to return our mocked session to be returned in our static method in the service.
    id myMockedSessionClass = OCMClassMock([NSURLSession class]);
    
    OCMStub([myMockedSessionClass sessionWithConfiguration: [OCMArg any]]).andReturn(myMockedURLSession);
    
    [GLNetworkService fetchStringsForLanguageCode:@"sv" withAppKey:@"" withAppId:@"" withCompletion:^(NSDictionary *stringDictionary, NSError *error) {
        if(stringDictionary.count == 13){
            [fetchCompletionExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        // Stop mocking
        [myMockedSessionClass stopMocking];
    }];
}

@end
