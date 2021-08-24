//
//  NSString+HMCategory.m
//  CommonTools-OC
//
//  Created by 心诚 on 2021/7/8.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

#import "NSString+HMCategory.h"

@implementation NSString (HMCategory)

+ (NSString *)uuid {
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}

+ (NSString *)random_uuid {
    
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef = CFUUIDCreateString(NULL, uuidRef);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    
    CFRelease(uuidRef);
    CFRelease(uuidStrRef);
    
    return uuid;
}


@end
