//
//  ColorCodeAppDelegate.h
//  Color Code
//
//  Created by Tim Garrison on 1/18/10.
//  Copyright 2010 Implied Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PreferencesController;

@interface ColorCodeAppDelegate : NSObject {
	NSStatusItem *statusItem;
	
	IBOutlet NSMenu *menu;
	IBOutlet PreferencesController *preferencesController;
	
	NSImage *statusImage;
	NSImage *statusImageSelected;
}

- (IBAction)sortFiles:(id)sender;
- (IBAction)showPreferences:(id)sender;
- (IBAction)checkForUpdates:(id)sender;
- (IBAction)showAbout:(id)sender;
- (IBAction)shutdown:(id)sender;

@end
