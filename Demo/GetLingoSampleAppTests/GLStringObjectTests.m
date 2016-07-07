//
//  GLStringObjectTests.m
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 28/04/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLStringObject.h"

@interface GLStringObjectTests : XCTestCase

@end

@implementation GLStringObjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetDictionary {
    NSDictionary *languageDictionary = @{
                                         @"id": @4,
                                         @"name": @"English",
                                         @"language_code": @"en"
                                         };
    NSDictionary *localizedStringDictionary = @{
                                         @"id": @81,
                                         @"key": @"SAMPLE_APP_DATE",
                                         @"value": @"December, 2015"
                                         };
    
    NSDictionary *testDictionary = @{
        @"id": @73,
        @"value": @"December, 2015",
        @"localized_string": localizedStringDictionary,
        @"language": languageDictionary
    };
    
    GLStringObject *testObject = [[GLStringObject alloc] initWithDictionary:testDictionary];
    
    [testObject.id isEqualToNumber:@73] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testObject.languageCode isEqualToString:@"en"] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testObject.language isEqualToString:@"English"] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testObject.key isEqualToString:localizedStringDictionary[@"key"]] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testObject.value isEqualToString:localizedStringDictionary[@"value"]] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");

}

@end
