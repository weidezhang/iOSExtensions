//
//  KeyChainWrapper.m
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 

#import "KeyChainWrapper.h"
#import <Security/Security.h>


@implementation KeyChainWrapper

+ (NSString *) keyChainErrorToString:(OSStatus)status
{
	switch (status) {
		case errSecSuccess:
			return @"errSecSuccess: No error";
			
		case errSecUnimplemented:
			return @"errSecUnimplemented: Function or operation not implemented.";
			
		case errSecParam:
			return @"errSecParam: One or more parameters passed to the function were not valid.";
			
		case errSecAllocate:
			return @"errSecAllocate: Failed to allocate memory.";
			
		case errSecNotAvailable:
			return @"errSecNotAvailable: No trust results are available.";
			
		case errSecDuplicateItem:
			return @"errSecDuplicateItem: The item already exists.";
			
		case errSecItemNotFound:
			return @"errSecItemNotFound: The item cannot be found.";
			
		case errSecInteractionNotAllowed:
			return @"errSecInteractionNotAllowed: Interaction with the Security Server is not allowed.";
			
		case errSecDecode:
			return @"errSecDecode: Unable to decode the provided data.";
			
		default:
			return @"Unknown error from KeyChain services.";
	}
}


+ (NSMutableDictionary*) newSearchQueryForUser:(NSString*)userEmail forService:(NSString*)service
{
	NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
	
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:service forKey:(id)kSecAttrService];
	[query setObject:userEmail forKey:(id)kSecAttrAccount];
	
	return query;
}


+ (NSMutableDictionary*) newSearchQueryForService:(NSString*)service
{
	NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
	
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:service forKey:(id)kSecAttrService];
	
	return query;
}


+ (void) printAttributes:(NSDictionary *)attributes
{
	NSArray *keys = [attributes allKeys];
	for (NSString *key in keys)
	{
//		NSLog(@"    %@ = %@", key, [attributes objectForKey:key]);
	}
}


+ (NSDictionary*) searchForUserEmail:(NSString*)userEmail forService:(NSString*)service
{
//	NSLog(@"userEmail: '%@'  service: '%@'", userEmail, service);
	
	NSMutableDictionary *searchQuery = [KeyChainWrapper newSearchQueryForUser:userEmail forService:service];
    [searchQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
	[searchQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
	
	NSMutableDictionary *searchResults = nil;
	
	OSStatus status = SecItemCopyMatching((CFDictionaryRef)searchQuery, (CFTypeRef *)&searchResults);
	[searchQuery release];
    
//	NSLog(@"    KeyChain status: %@", [KeyChainWrapper keyChainErrorToString:status]);
	
	if (status != errSecSuccess)
		return nil;
	
	return [searchResults autorelease];
}


+ (BOOL) createEntryForUser:(NSString*)userEmail entryValue:(NSString*)entryValue forService:(NSString*)service
{
//	NSLog(@"userEmail: '%@'  service: '%@'", userEmail, service);
	NSDictionary *searchResults = [KeyChainWrapper searchForUserEmail:userEmail forService:service];
	
	OSStatus status = errSecSuccess;
	
	if (searchResults != nil) 
		[KeyChainWrapper removeEntryForUserEmail:userEmail forService:service];
	
	NSData* encodedValue = [entryValue dataUsingEncoding:NSUTF8StringEncoding];
	
	NSMutableDictionary *searchQuery = nil;
	searchQuery = [KeyChainWrapper newSearchQueryForUser:userEmail forService:service];
	
	[searchQuery setObject:encodedValue forKey:(id)kSecValueData];
	[searchQuery setObject:(id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly forKey:(id)kSecAttrAccessible];
	
	status = SecItemAdd((CFDictionaryRef)searchQuery, NULL);

	if (status != errSecSuccess)
		[self printAttributes:searchQuery];
	
//	NSLog(@"    KeyChain status: %@", [KeyChainWrapper keyChainErrorToString:status]);
    [searchQuery release];

	return (status == errSecSuccess);
}


+ (NSString*) retrieveEntryForUser:(NSString*)userEmail forService:(NSString*)service
{
//	NSLog(@"userEmail: '%@'  service: '%@'", userEmail, service);
	
	NSMutableDictionary *searchQuery = [KeyChainWrapper newSearchQueryForUser:userEmail forService:service];
    [searchQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	
    NSData *entryData = nil;
	
	OSStatus status = SecItemCopyMatching((CFDictionaryRef)searchQuery, (CFTypeRef *)&entryData);
//	NSLog(@"    KeyChain status: %@", [KeyChainWrapper keyChainErrorToString:status]);
    [searchQuery release];

	if (status != errSecSuccess)
		return nil;
	
	NSString *decodedValue = [[NSString alloc] initWithBytes:[entryData bytes] 
													  length:[entryData length]
													encoding:NSUTF8StringEncoding];
	
	[entryData release];
	
	return [decodedValue autorelease];
}


+ (BOOL) isEntryStoredForUserEmail:(NSString*)userEmail forService:(NSString*)service
{
//	NSLog(@"userEmail: '%@'  service: '%@'", userEmail, service);
	
	NSMutableDictionary *searchQuery = [KeyChainWrapper newSearchQueryForUser:userEmail forService:service];
    [searchQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	
    NSData *entryData = nil;
	
 	OSStatus status = SecItemCopyMatching((CFDictionaryRef)searchQuery, (CFTypeRef *)&entryData);
//	NSLog(@"    KeyChain status: %@", [KeyChainWrapper keyChainErrorToString:status]);
    
	if (status != errSecSuccess)
		[self printAttributes:searchQuery];

    [searchQuery release];
    [entryData release];
	
	return (status == errSecSuccess);
}


+ (BOOL) removeEntryForUserEmail:(NSString*)userEmail forService:(NSString*)service
{
//	NSLog(@"userEmail: '%@'  service: '%@'", userEmail, service);
	
	NSMutableDictionary *searchQuery = [KeyChainWrapper newSearchQueryForUser:userEmail forService:service];
	[searchQuery removeObjectForKey:(id)kSecValueData];
	
	OSStatus status = SecItemDelete((CFDictionaryRef)searchQuery);
//	NSLog(@"    KeyChain status: %@", [KeyChainWrapper keyChainErrorToString:status]);

	if (status != errSecSuccess)
		[self printAttributes:searchQuery];

    [searchQuery release];
	
	return (status == errSecSuccess);
}


@end

