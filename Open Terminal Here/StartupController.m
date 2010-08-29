/*
 *		NSObject subclass to get key-down information at startup 
 *
 *		Adapated from the excellent MacScripts
 *			http://bbs.applescript.net/viewtopic.php?id=19065
 *  
 */

#import "StartupController.h"
#import <Carbon/Carbon.h>

@implementation StartupController

+(BOOL)cmdKeyDown {
    return ((GetCurrentKeyModifiers() & cmdKey) != 0);
}

+(BOOL)optKeyDown {
    return ((GetCurrentKeyModifiers() & optionKey) != 0);
}

//... you can also use 'optionKey', 'cmdKey', or 'shiftKey' in place of "controlKey"
@end