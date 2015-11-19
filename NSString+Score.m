//
//  NSString+Score.m
//
//  Created by Nicholas Bruning on 5/12/11.
//  Copyright (c) 2011 Involved Pty Ltd. All rights reserved.
//

//score reference: http://jsfiddle.net/JrLVD/

#import "NSString+Score.h"

static NSCharacterSet *s_invalidCharacterSet = nil;
static NSCharacterSet *s_separatorsCharacterSet = nil;

@implementation NSString (Score)

- (CGFloat) scoreAgainst:(NSString *)otherString{
    return [self scoreAgainst:otherString fuzziness:nil];
}

- (CGFloat) scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness{
    return [self scoreAgainst:otherString fuzziness:fuzziness options:NSStringScoreOptionNone];
}

- (CGFloat) scoreAgainst:(NSString *)anotherString fuzziness:(NSNumber *)fuzziness options:(NSStringScoreOption)options{

	if (s_invalidCharacterSet == nil) {
		NSMutableCharacterSet *separatorsCharacterSet = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
		[separatorsCharacterSet formUnionWithCharacterSet:[NSMutableCharacterSet punctuationCharacterSet]];
		s_separatorsCharacterSet = separatorsCharacterSet;
		
		NSMutableCharacterSet *validCharacterSet = [NSMutableCharacterSet alphanumericCharacterSet];
		[validCharacterSet formUnionWithCharacterSet:s_separatorsCharacterSet];
		
		s_invalidCharacterSet = [validCharacterSet invertedSet];
	}

	
    NSString *string = [[[self decomposedStringWithCanonicalMapping] componentsSeparatedByCharactersInSet:invalidCharacterSet] componentsJoinedByString:@""];
    NSString *otherString = [[[anotherString decomposedStringWithCanonicalMapping] componentsSeparatedByCharactersInSet:invalidCharacterSet] componentsJoinedByString:@""];

    // If the string is equal to the abbreviation, perfect match.
    if([string isEqualToString:otherString]) return (CGFloat) 1.0f;
	
    //if it's not a perfect match and is empty return 0
    if([otherString length] == 0) return (CGFloat) 0.0f;
	
	CGFloat bestCharacterScore = 0;
    NSUInteger otherStringLength = [otherString length];
    NSUInteger stringLength = [string length];
    BOOL startOfStringBonus = NO;
    CGFloat otherStringScore;
    CGFloat fuzzies = 1;
    CGFloat finalScore;
	
	for (NSInteger testStringStartingIndex = 0; testStringStartingIndex < stringLength; testStringStartingIndex++) {
		NSString *testString = [string substringFromIndex:testStringStartingIndex];
		CGFloat totalCharacterScore = 0;

		// Walk through abbreviation and add up scores.
		for(uint index = 0; index < otherStringLength; index++){
			CGFloat characterScore = 0.1;
			NSInteger indexInString = NSNotFound;
			unichar chr = [otherString characterAtIndex:index];
			NSRange rangeChrLowercase = [testString rangeOfString:[[otherString substringWithRange:NSMakeRange(index, 1)] lowercaseString]];
			NSRange rangeChrUppercase = [testString rangeOfString:[[otherString substringWithRange:NSMakeRange(index, 1)] uppercaseString]];
			
			if(rangeChrLowercase.location == NSNotFound && rangeChrUppercase.location == NSNotFound){
				if(fuzziness){
					fuzzies += 1 - [fuzziness floatValue];
				} else {
					return 0; // this is an error!
				}
			} else if (rangeChrLowercase.location != NSNotFound && rangeChrUppercase.location != NSNotFound){
				indexInString = MIN(rangeChrLowercase.location, rangeChrUppercase.location);
			} else if(rangeChrLowercase.location != NSNotFound || rangeChrUppercase.location != NSNotFound){
				indexInString = rangeChrLowercase.location != NSNotFound ? rangeChrLowercase.location : rangeChrUppercase.location;
			} else {
				indexInString = MIN(rangeChrLowercase.location, rangeChrUppercase.location);
			}
			
			// Set base score for matching chr
			
			// Same case bonus.
			if(indexInString != NSNotFound && [testString characterAtIndex:indexInString] == chr){
				characterScore += 0.1;
			}
			
			// Consecutive letter & start-of-string bonus
			if(indexInString == 0){
				// Increase the score when matching first character of the remainder of the string
				characterScore += 0.6;
				if(index == 0 && testStringStartingIndex == 0){
					// If match is the first character of the string
					// & the first character of abbreviation, add a
					// start-of-string match bonus.
					startOfStringBonus = YES;
				}
			} else if(indexInString != NSNotFound) {
				// Acronym Bonus
				// Weighing Logic: Typing the first character of an acronym is as if you
				// preceded it with two perfect character matches.
				if ([separatorsCharacterSet characterIsMember:[testString characterAtIndex:indexInString - 1]]) {
					characterScore += 0.8;
				}
			}
			
			totalCharacterScore += characterScore;

			// Left trim the already matched part of the string
			// (forces sequential matching).
			if(indexInString != NSNotFound){
				testString = [testString substringFromIndex:indexInString + 1];
			}
		}
		bestCharacterScore = MAX(totalCharacterScore, bestCharacterScore);
	}
	
    if(NSStringScoreOptionFavorSmallerWords == (options & NSStringScoreOptionFavorSmallerWords)){
        // Weigh smaller words higher
        return bestCharacterScore / stringLength;
    } 
    
    otherStringScore = bestCharacterScore / otherStringLength;
    
    if(NSStringScoreOptionReducedLongStringPenalty == (options & NSStringScoreOptionReducedLongStringPenalty)){
        // Reduce the penalty for longer words
        CGFloat percentageOfMatchedString = otherStringLength / stringLength;
        CGFloat wordScore = otherStringScore * percentageOfMatchedString;
        finalScore = (wordScore + otherStringScore) / 2;
        
    } else {
        finalScore = ((otherStringScore * ((CGFloat)(otherStringLength) / (CGFloat)(stringLength))) + otherStringScore) / 2;
    }
    
    finalScore = finalScore / fuzzies;
    
    if(startOfStringBonus && finalScore + 0.15 < 1){
        finalScore += 0.15;
    }
    
    return finalScore;
}

@end
