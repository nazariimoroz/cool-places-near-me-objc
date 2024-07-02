#import <Foundation/Foundation.h>
#import <stdio.h>
#import "CoolPlacesNearMe.h"


int main(void)
{
    @autoreleasepool{
        @try
        {
            char path_to_json[255];
            printf("FULL path to json: "); scanf("%s", path_to_json);
            double radius_of_search = 0.;
            printf("Radius of search(km): "); scanf("%lf", &radius_of_search);

            CoolPlacesNearMe* cpnm = [[CoolPlacesNearMe alloc] 
                initWithCord:       NSMakePoint(48.471207,35.038810) 
                andPathToJson:      [NSString stringWithCString: path_to_json] 
                andRadiusOfSearch:  [NSNumber numberWithDouble: radius_of_search]];

            NSDictionary* dict = [cpnm getCoolPlacesNearMe];
            for(NSString* key in dict)
                NSLog(@"Place: %@; Distance %.5lf km", key, [[dict objectForKey:key] doubleValue]);

        } @catch(NSException* e)
        {
            NSLog(@"%@", e);
        }
    }
}