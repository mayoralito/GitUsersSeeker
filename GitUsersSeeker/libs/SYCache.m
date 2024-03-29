//
//  SYCache.m
//  SYCache
//
//  Created by Sam Soffes on 10/31/11.
//  Copyright (c) 2011 Synthetic. All rights reserved.
//

#import "SYCache.h"
#import "AFNetworking/AFNetworkReachabilityManager.h"

@interface SYCache (Private)
- (NSString *)_pathForKey:(NSString *)key;
@end

@implementation SYCache {
	NSCache *_cache;
	dispatch_queue_t _queue;
	NSFileManager *_fileManager;
	NSString *_cacheDirectory;
}

@synthesize name = _name;

#pragma mark - NSObject

- (id)init {
	NSLog(@"[SYCache] You must initalize SYCache using `initWithName:`.");
	[self autorelease];
	return nil;
}


- (void)dealloc {
	[_cache removeAllObjects];
	[_cache release];
	_cache = nil;
	
	dispatch_release(_queue);
	_queue = nil;
	
	[_name release];
	_name = nil;
	
	[_fileManager release];
	_fileManager = nil;
	
	[_cacheDirectory release];
	_cacheDirectory = nil;
	
	[super dealloc];
}


#pragma mark - Getting the Shared Cache

+ (SYCache *)sharedCache {
	static SYCache *sharedCache = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedCache = [[SYCache alloc] initWithName:@"sycache.shared"];
	});
	return sharedCache;
}


#pragma mark - Initializing


- (id)initWithName:(NSString *)name {
	if ((self = [super init])) {
		_name = [name copy];
		
		_cache = [[NSCache alloc] init];
		_cache.name = name;
		
		_queue = dispatch_queue_create([name cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_SERIAL);
		
		_fileManager = [[NSFileManager alloc] init];
		NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
		_cacheDirectory = [[cachesDirectory stringByAppendingFormat:@"/com.touchpad.sycache.shared/%@", name] retain];
		
		if (![_fileManager fileExistsAtPath:_cacheDirectory]) {
			[_fileManager createDirectoryAtPath:_cacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
		}
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
	}
	return self;
}

- (void)didMemoryWarning:(NSNotification*)note {
    [self dealloc];
}


#pragma mark - Getting a Cached Value

- (id)objectForKey:(NSString *)key {
	__block id object = [_cache objectForKey:key];
	if (object) {
		return object;
	}
	
	// Get path if object exists
	NSString *path = [self pathForKey:key];
	if (!path) {
		return nil;
	}
	
	// Load object from disk
	object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
	
	// Store in cache
    if(key && object){
        [_cache setObject:object forKey:key];
    }
	
	
	return object;
}


- (void)objectForKey:(NSString *)key usingBlock:(void (^)(id object))block {
	dispatch_sync(_queue, ^{
		id object = [[_cache objectForKey:key] retain];
		if (!object) {
			object = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self _pathForKey:key]] retain];
            if(key && object){
                [_cache setObject:object forKey:key];
            }
		}
		
		block([object autorelease]);
	});
}


- (BOOL)objectExistsForKey:(NSString *)key {
	__block BOOL exists = ([_cache objectForKey:key] != nil);
	if (exists) {
		return YES;
	}
	
	dispatch_sync(_queue, ^{
		exists = [_fileManager fileExistsAtPath:[self _pathForKey:key]];
	});
	return exists;
}


#pragma mark - Adding and Removing Cached Values

- (void)setObject:(id)object forKey:(NSString *)key {
	if (!object) {
		return;
	}
	
	dispatch_async(_queue, ^{
		NSString *path = [self _pathForKey:key];
		
		// Stop if in memory cache or disk cache
		if (([_cache objectForKey:key] != nil) || [_fileManager fileExistsAtPath:path]) {
			return;
		}
		
		// Save to memory cache
        if(key && object){
            [_cache setObject:object forKey:key];
        }
		
		// Save to disk cache
		[NSKeyedArchiver archiveRootObject:object toFile:[self _pathForKey:key]];
	});
}


- (void)removeObjectForKey:(id)key {
	[_cache removeObjectForKey:key];
	
	dispatch_async(_queue, ^{
		[_fileManager removeItemAtPath:[self _pathForKey:key] error:nil];
	});
}


- (void)removeAllObjects {
	[_cache removeAllObjects];
	
	dispatch_async(_queue, ^{
		for (NSString *path in [_fileManager contentsOfDirectoryAtPath:_cacheDirectory error:nil]) {
			[_fileManager removeItemAtPath:[_cacheDirectory stringByAppendingPathComponent:path] error:nil];
		}
	});
}


#pragma mark - Accessing the Disk Cache

- (NSString *)pathForKey:(NSString *)key {
	if ([self objectExistsForKey:key]) {
		return [self _pathForKey:key];
	}
	return nil;
}


#pragma mark - Private

- (NSString *)_pathForKey:(NSString *)key {
	return [_cacheDirectory stringByAppendingPathComponent:key];
}

@end


#if TARGET_OS_IPHONE

@interface SYCache (UIImagePrivateAdditions)
+ (NSString *)_keyForImageKey:(NSString *)imageKey;
@end

@implementation SYCache (UIImageAdditions)

- (UIImage *)imageForKey:(NSString *)key {
	key = [[self class] _keyForImageKey:key];
	
	__block UIImage *image = [_cache objectForKey:key];
	if (image) {
		return image;
	}
	
	// Get path if object exists
	NSString *path = [self pathForKey:key];
	if (!path) {
		return nil;
	}
	
	// Load object from disk
	image = [UIImage imageWithContentsOfFile:path];
	
	// Store in cache
    if(key && image){
        [_cache setObject:image forKey:key];
    }
	
	return image;
}


- (void)imageForKey:(NSString *)key usingBlock:(void (^)(UIImage *image))block {
	key = [[self class] _keyForImageKey:key];
	
	dispatch_sync(_queue, ^{
		UIImage *image = [[_cache objectForKey:key] retain];
		if (!image) {
			image = [[UIImage alloc] initWithContentsOfFile:[self _pathForKey:key]];
            if(key && image){
                [_cache setObject:image forKey:key];
            }
			
		}
		
		block([image autorelease]);
	});
}


- (void)setImage:(UIImage *)image forKey:(NSString *)key {
	if (!image) {
		return;
	}
    
	if([key isEqualToString:@""]) {
        return;
    }
    
	key = [[self class] _keyForImageKey:key];
	
	dispatch_async(_queue, ^{
		NSString *path = [self _pathForKey:key];
		
		// Stop if in memory cache or disk cache
		if (([_cache objectForKey:key] != nil) || [_fileManager fileExistsAtPath:path]) {
			return;
		}
        
		// Save to memory cache
        if(key && image){
            [_cache setObject:image forKey:key];
        }
		
		// Save to disk cache
		[UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
	});
}

- (UIImage *)imageWithDefaultForKey:(NSString *)key {
		
	__block UIImage *image = [self imageForKey:key];
    if(nil==image){
        image = [UIImage imageNamed:@"default_poster"];
    }
    
    CGImageRef cgref = [image CGImage];
    CIImage *cim = [image CIImage];
    if (cim == nil && cgref == NULL)
    {
        NSLog(@"no underlying data");
        image = [UIImage imageNamed:@"default_poster"];
    }
	
	return image;
}

- (UIImage *)imageWithDefaultForKey:(NSString *)key withFullPath :  (NSString *)fullPath
{
    __block UIImage *image = [self imageForKey:key];
    if(nil==image){
        image = [UIImage imageNamed:@"default_poster"];
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
            
            if( AFNetworkReachabilityStatusNotReachable == AFStringFromNetworkReachabilityStatus(status)){
                NSString *imageName = [fullPath lastPathComponent];
                UIImage *saveImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fullPath]] ];
                [self setImage:saveImage forKey:imageName];
                
                image = [self imageForKey:imageName];
            }
        }];
        
    }
    
    CGImageRef cgref = [image CGImage];
    CIImage *cim = [image CIImage];
    if (cim == nil && cgref == NULL)
    {
        NSLog(@"no underlying data");
        image = [UIImage imageNamed:@"default_poster"];
    }
	
	return image;
}

- (void)imageWithKey:(NSString*)key withFullPath : (NSString *)fullPath completionHandler:(ImageCacheDownloadCompletionHandler)completion
{
    __block UIImage *image = [self imageForKey:key];
    if (image) {
        completion(image);
    } else {
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSString *imageName = [fullPath lastPathComponent];
            UIImage *saveImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fullPath]] ];
            
            [self setImage:saveImage forKey:imageName];
            image = [self imageForKey:imageName];
            dispatch_sync(dispatch_get_main_queue(), ^{
                image = [self imageForKey:[fullPath lastPathComponent]];
                if(!image){
                    image = [UIImage imageNamed:@"default_poster"];
                }
                completion(image);
            });
        });
        
    }
}

#pragma mark - Private

+ (NSString *)_keyForImageKey:(NSString *)imageKey {
	NSString *scale = [[UIScreen mainScreen] scale] == 2.0f ? @"@2x" : @"";
	return [imageKey stringByAppendingFormat:@"%@.png", scale];
}

#endif

@end