//
//  LibT280.m
//  LibT280
//
//  Created by Clay Miller on 11/30/17.
//  Copyright © 2017 Clay Miller. All rights reserved.
//

// Inspired by https://twitter.com/kracksundkatzen/status/930215665239248896

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface ITwitterComposition : NSObject

- (int)characterLimit;

@end

@implementation ITwitterComposition

- (int)characterLimit {
    return 280;
}

@end

__attribute__((constructor)) void entry() {
    method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"TwitterComposition"), @selector(characterLimit)), class_getInstanceMethod(NSClassFromString(@"ITwitterComposition"), @selector(characterLimit)));
}

