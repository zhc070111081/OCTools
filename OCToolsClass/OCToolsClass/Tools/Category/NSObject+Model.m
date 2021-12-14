//
//  NSObject+Model.m
//  OCToolsClass
//
//  Created by zhuhc on 2021/9/16.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

- (void)temp {
    
    unsigned int count = 0;
    class_copyIvarList([self class], &count);
    
}

@end
