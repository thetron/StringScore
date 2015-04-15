# StringScore

StringScore is an Objective-C library which provides super fast fuzzy string matching/scoring. Based on the [JavaScript library of the same name](https://github.com/joshaven/string_score), by [Joshaven Potter](https://github.com/joshaven).

## Using StringScore

StringScore adds 3 new methods to `NSString`:

````
- (CGFloat) scoreAgainst:(NSString*)otherString;

- (CGFloat) scoreAgainst:(NSString*)otherString 
               fuzziness:(NSNumber*)f;
               
- (CGFloat) scoreAgainst:(NSString*)otherString 
               fuzziness:(NSNumber*)f 
                 options:(NSStringScoreOption)opts;
````

All three methods return a `CGFloat` representing how closely the string matched the `otherString` parameter.


## Additional Parameters
### Fuzziness

A number between 0 and 1 which varys how fuzzy/ the calculation is. Defaults to `nil` (fuzziness disabled).

### Options

There are 3 options available: 

````
NSStringScoreOptionNone
NSStringScoreOptionFavorSmallerWords
NSStringScoreOptionReducedLongStringPenalty
````

Each of which is pretty self-explanatory, see example below for usage.


## Examples

Given the following sample application:

````
#define prnt_(Z)  printf("Result %i = %f\n", ctr++, Z); 

NSString *test = @"Hello world!"; int ctr = 1;

prnt_( [test scoreAgainst:@"Hello world!"]                             );
prnt_( [test scoreAgainst:@"HW"]  /* abbreviation matching */          ); 
prnt_( [test scoreAgainst:@"world"]                                    );
prnt_( [test scoreAgainst:@"wXrld" fuzziness:@(0.8)]                   );
prnt_( [test scoreAgainst:@"world" fuzziness:nil 
                  options:NSStringScoreOptionFavorSmallerWords]        );
prnt_( [test scoreAgainst:@"world" fuzziness:nil 
                  options:NSStringScoreOptionFavorSmallerWords
                         |NSStringScoreOptionReducedLongStringPenalty] );

````
The resulting output is:

````
Result 1 = 1.000000
Result 2 = 0.000000
Result 3 = 0.528889
Result 4 = 0.361111
Result 5 = 0.377778
Result 6 = 0.377778
````

## Credits

Author: [Nicholas Bruning](https://github.com/thetron)

Special thanks to [Joshaven Potter](https://github.com/joshaven) for providing the basis for this library.

## License

Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php).