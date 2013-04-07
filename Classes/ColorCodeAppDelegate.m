//
//  ColorCodeAppDelegate.m
//  Color Code
//
//  Created by Tim Garrison on 1/18/10.
//  Copyright 2010 Implied Solutions. All rights reserved.
//

#import "ColorCodeAppDelegate.h"
#import "ColorCode.h"
#import "PreferencesController.h"
#import "UserSettings.h"



@implementation ColorCodeAppDelegate

- (id)init {
    if ( self = [super init] ) {
    }
    return self;
}

- (void)dealloc {
	//[menu release];
	[statusImage release];
	[statusImageSelected release];
	[super dealloc];
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
    UserSettings *userSettings = [[UserSettings alloc] init];
    if ( 2 == [userSettings addToLoginItems] ) {
        NSString *humanReadableError = @"Unable to add to Login Items, this app will not launch automatically at Login";
        [NSApp activateIgnoringOtherApps:YES];
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:humanReadableError];
        [alert runModal];
        return;
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [menu release];
    [[NSStatusBar systemStatusBar] removeStatusItem:statusItem];
    [statusItem release];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {    
    
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
	
	NSBundle *bundle = [NSBundle mainBundle];
	
	statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"colorCodeMenu" ofType:@"png"]];
	statusImageSelected = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"colorCodeMenuSelected" ofType:@"png"]];
	
	[statusItem setImage:statusImage];
	[statusItem setAlternateImage:statusImageSelected];
	
	
	[statusItem setMenu:menu];
	[statusItem setToolTip:@"Color Code"];
	[statusItem setHighlightMode:YES];
}	

- (IBAction)sortFiles:(id)sender {
	ColorCode *colorCode = [[ColorCode alloc] init];
	[colorCode moveFilesFromSourceDirectoryToDestinationDirectoriesByColor];
	[colorCode release];
}

- (IBAction)showPreferences:(id)sender {
	if ( !preferencesController ) {
		[NSBundle loadNibNamed:@"PreferencesController" owner:self];
	}
	[preferencesController showPreferencesPanel];
}

- (IBAction)checkForUpdates:(id)sender {
	NSLog(@"checking for updates");
}

- (IBAction)showAbout:(id)sender {
	[NSApp activateIgnoringOtherApps:YES];
    [NSApp orderFrontStandardAboutPanel:sender];
}

- (IBAction)shutdown:(id)sender {
	[NSApp replyToApplicationShouldTerminate:YES];
	[NSApp terminate:sender];
}

@end