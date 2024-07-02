#import <Foundation/Foundation.h>

@interface CoolPlacesNearMe : NSObject
{
@private
    NSPoint m_base_point;
    NSMutableDictionary* m_json_array;
    NSNumber* m_radius_of_search;
}

-(instancetype)
    initWithCord: (NSPoint)base_point 
    andPathToJson: (NSString*)path_to_json_file 
    andRadiusOfSearch: (NSNumber*)radius_of_search;

-(NSMutableDictionary*) getCoolPlacesNearMe;

@end
