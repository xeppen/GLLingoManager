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
    NSDictionary *testDictionary = @{
        @"id": @33,
        @"value": @"Parking allowed",
        @"created_at": @"2016-04-02T19:49:40.682Z",
        @"updated_at": @"2016-04-02T19:49:40.682Z",
        @"language_id": @4,
        @"language": languageDictionary,
        @"localized_string": @{
            @"id": @7,
            @"key": @"PARKING_RULE_PARKING_VERDICT_ALLOWED"
        }
    };
    
    GLStringObject *testObject = [[GLStringObject alloc] init];
    testObject.dictionary = testDictionary;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *testCreatedString = @"2016-04-02";
    
    [testCreatedString isEqualToString:[formatter stringFromDate:testObject.createdAt]] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testCreatedString isEqualToString:[formatter stringFromDate:testObject.updatedAt]] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testObject.id isEqualToNumber:@33] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testObject.languageCode isEqualToString:@"en"] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testObject.language isEqualToString:@"English"] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testObject.key isEqualToString:@"PARKING_RULE_PARKING_VERDICT_ALLOWED"] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");
    [testObject.value isEqualToString:@"Parking allowed"] ? XCTAssert(YES, @"Pass") : XCTAssert(NO, @"Pass");

}

@end
