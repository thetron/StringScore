# StringScore

StringScore is an Objective-C library which provides super fast fuzzy string matching/scoring. Based on the [JavaScript library of the same name](https://github.com/joshaven/string_score), by [Joshaven Potter](https://github.com/joshaven).


## Using StringScore

StringScore adds 3 new methods to `NSString`:

````
- (CGFloat) scoreAgainst:(NSString *)otherString;

- (CGFloat) scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness;

- (CGFloat) scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness options:(NSStringScoreOption)options;
````

All three methods return a `CGFloat` representing how closely the string
matched the `otherString` parameter.


## Additional Parameters

### Fuzziness

A number between 0 and 1 which varys how fuzzy/ the calculation is.
Defaults to `nil` (fuzziness disabled).


### Options

There are 3 options available: `NSStringScoreOptionNone`, `NSStringScoreOptionFavorSmallerWords` and `NSStringScoreOptionReducedLongStringPenalty`. Each of which is pretty self-explanatory, see example below for usage.


## Examples

Given the following sample application:

````
NSString *testString = @"Hello world!";

CGFloat result1 = [testString scoreAgainst:@"Hello world!"];
CGFloat result2 = [testString scoreAgainst:@"world"];
CGFloat result3 = [testString scoreAgainst:@"wXrld" fuzziness:[NSNumber numberWithFloat:0.8]];
CGFloat result4 = [testString scoreAgainst:@"world" fuzziness:nil options:NSStringScoreOptionFavorSmallerWords];
CGFloat result5 = [testString scoreAgainst:@"world" fuzziness:nil options:(NSStringScoreOptionFavorSmallerWords | NSStringScoreOptionReducedLongStringPenalty)];
CGFloat result6 = [testString scoreAgainst:@"HW"]; // abbreviation matching example

NSLog(@"Result 1 = %f", result1);
NSLog(@"Result 2 = %f", result2);
NSLog(@"Result 3 = %f", result3);
NSLog(@"Result 4 = %f", result4);
NSLog(@"Result 5 = %f", result5);
NSLog(@"Result 6 = %f", result6);
````

The resulting output is:

````
2012-05-14 15:13:38.074 StringScore[13415:18a03] Result 1 = 1.000000
2012-05-14 15:13:38.075 StringScore[13415:18a03] Result 2 = 0.425000
2012-05-14 15:13:38.075 StringScore[13415:18a03] Result 3 = 0.271528
2012-05-14 15:13:38.076 StringScore[13415:18a03] Result 4 = 0.250000
2012-05-14 15:13:38.077 StringScore[13415:18a03] Result 5 = 0.425000
2012-05-14 15:13:38.078 StringScore[13415:18a03] Result 6 = 0.645833
````

## Credits

Author: [Nicholas Bruning](https://github.com/thetron)

Special thanks to [Joshaven Potter](https://github.com/joshaven) for
providing the basis for this library.


## License

Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php).
