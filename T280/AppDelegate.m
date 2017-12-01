//
//  AppDelegate.m
//  T280
//
//  Created by Clay Miller on 11/30/17.
//  Copyright © 2017 Clay Miller. All rights reserved.
//

// Inspired by https://blog.timac.org/2012/1218-simple-code-injection-using-dyld_insert_libraries/

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

-(void)bringToFrontApplicationWithBundleIdentifier:(NSString*)inBundleIdentifier {
	// Attempt to activate application
	NSArray* appsArray = [NSRunningApplication runningApplicationsWithBundleIdentifier:inBundleIdentifier];
	if([appsArray count] > 0) {
		[[appsArray objectAtIndex:0] activateWithOptions:NSApplicationActivateIgnoringOtherApps];
	}
	
	// Terminate
	[[NSApplication sharedApplication] terminate:self];
}

-(void)launchApplicationWithPath:(NSString*)inPath andBundleIdentifier:(NSString*)inBundleIdentifier {
	if(inPath != nil) {
		// Run application and inject dynamic library
		NSString *dylib = [[NSBundle bundleForClass:[self class]] pathForResource:@"LibT280" ofType:@"dylib"];
		NSString *launcherString = [NSString stringWithFormat:@"DYLD_INSERT_LIBRARIES=\"%@\" \"%@\" &", dylib, inPath];
//        NSString *launcherString = [NSString stringWithFormat:@"\"%@\" &", inPath];
		system([launcherString UTF8String]);
		
		// Activate application after a delay
		[self performSelector:@selector(bringToFrontApplicationWithBundleIdentifier:) withObject:inBundleIdentifier afterDelay:1.0];
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSString *appPath = @"/Applications/Twitter.app/Contents/MacOS/Twitter";
	if([[NSFileManager defaultManager] fileExistsAtPath:appPath])
		[self launchApplicationWithPath:appPath andBundleIdentifier:@"com.twitter.twitter-mac"];
}

@end
