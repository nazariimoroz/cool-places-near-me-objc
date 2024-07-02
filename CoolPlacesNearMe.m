#import "CoolPlacesNearMe.h"
#include <math.h>

#define pi 3.14159265358979323846

typedef enum 
{
    MILES, KILOMETERS 
} UnitDesire;

@interface CoolPlacesNearMe()
    -(void)initJsonDictWithPathToJson: (NSString*)path_to_json_file;
    +(double)distanceBetweenPointLat: (double) lat1 Lon: (double) lon1
            andPointLat: (double) lat2 Lon: (double) lon2
            unitDesire: (UnitDesire)unit; 
    +(double)deg2rad: (double) deg;
    +(double)rad2deg: (double) rad;
    
@end


@implementation CoolPlacesNearMe

-(instancetype)
    initWithCord: (NSPoint)base_point 
    andPathToJson: (NSString*)path_to_json_file 
    andRadiusOfSearch: (NSNumber*)radius_of_search
{
    self = [super init];
    if(self)
    {
        m_base_point.x = base_point.x;
        m_base_point.y = base_point.y;

        [self initJsonDictWithPathToJson: path_to_json_file];

        m_radius_of_search = radius_of_search;
    }
    return self;
}

-(NSMutableDictionary*) getCoolPlacesNearMe
{
    NSMutableDictionary* to_ret = [NSMutableDictionary dictionary];
    for(NSDictionary* data in [m_json_array objectForKey: @"candidates"])
    {
        NSPoint point = NSMakePoint(
            [[[[data objectForKey:@"geometry"] objectForKey:@"location"] objectForKey: @"lat"] doubleValue],
            [[[[data objectForKey:@"geometry"] objectForKey:@"location"] objectForKey: @"lng"] doubleValue]
        );
        NSString* name = [data objectForKey: @"name"];
        double dist = [[self class] distanceBetweenPointLat: point.x Lon: point.y
                            andPointLat: m_base_point.x Lon: m_base_point.y 
                            unitDesire: KILOMETERS]; 
        if(dist > [m_radius_of_search doubleValue])
            continue;

        [to_ret setObject: [NSNumber numberWithDouble: dist] forKey: name];
    }
    return to_ret;
}





-(void)initJsonDictWithPathToJson: (NSString*)path_to_json_file
{
    NSFileManager* file_manager = [NSFileManager defaultManager];
    if(![file_manager fileExistsAtPath: path_to_json_file])
        @throw [NSException 
            exceptionWithName: @"FileManagerException" 
            reason: @"File does not exists"
            userInfo: nil];

    NSData* file_data = [file_manager contentsAtPath: path_to_json_file];

    m_json_array = (NSMutableDictionary*)[NSJSONSerialization 
                        JSONObjectWithData: file_data 
                        options: NSJSONReadingMutableContainers 
                        error: NULL];

    if(!m_json_array)
        @throw [NSException 
            exceptionWithName: @"JsonError" 
            reason: @"Error while parsing json"
            userInfo: nil];
}

+(double)distanceBetweenPointLat: (double) lat1 Lon: (double) lon1
    andPointLat: (double) lat2 Lon: (double) lon2
    unitDesire: (UnitDesire)unit 
{
    double theta, dist;
    if ((lat1 == lat2) && (lon1 == lon2)) {
        return 0;
    }
    else {
        theta = lon1 - lon2;
        dist = sin([self deg2rad: lat1]) 
             * sin([self deg2rad: lat2]) 
             + cos([self deg2rad: lat1]) 
             * cos([self deg2rad: lat2]) 
             * cos([self deg2rad: theta]);
        dist = acos(dist);
        dist = [self rad2deg: dist];
        dist = dist * 60 * 1.1515;
        switch(unit) {
        case MILES:
            break;
        case KILOMETERS:
            dist = dist * 1.609344;
            break;
        }
    return (dist);
    }
}

+(double)deg2rad: (double) deg
{
    return (deg * pi / 180);
}
+(double)rad2deg: (double) rad
{
    return (rad * 180 / pi);
}

@end