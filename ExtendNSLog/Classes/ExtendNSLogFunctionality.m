//
//  ExtendNSLogFunctionality.m
//  ExtendNSLog
//
//  Created by cncn on 13-9-12.
//  Copyright (c) 2013年 cncn. All rights reserved.
//

#import "ExtendNSLogFunctionality.h"

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...)
{
    // Type to hold information about variable arguments.
    va_list ap;
    
    // Initialize a variable argument list.
    va_start (ap, format);
    
    // NSLog only adds a newline to the end of the NSLog format if
    // one is not already there.
    // Here we are utilizing this feature of NSLog()
    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
    }
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    
    // End using variable argument list.
    va_end (ap);
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
	NSString *currentDateString = [formatter stringFromDate:[NSDate date]];
    
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
	fprintf(stderr, "%s %s (%s:%d) %s",
			[currentDateString UTF8String],
			functionName, [fileName UTF8String],
			lineNumber, [body UTF8String]);
}