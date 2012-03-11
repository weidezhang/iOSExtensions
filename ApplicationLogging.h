//
//  ApplicationLogging.h
//
//  Licensed by ruralcoder.com under the
//  Creative Commons Attribution-ShareAlike 3.0 Unported License 


#define DEBUG_LOGS 0
#define NETWORK_LOGS 0
#define HTTP_REQUEST_LOGS 0
#define APPLICATION_LOGS 0
#define SOCIAL_LOGS 0
#define ALLOC_LOGS 0
#define SUMMARY_LOGS 0
#define OPERATION_QUEUE_LOGS 0
#define ERROR_LOGS 0


#if HTTP_REQUEST_LOGS == 1
#warning "HTTP_REQUEST_LOGS are ON - disable in release."
#    define HttpLog(...) NSLog(__VA_ARGS__)
#else
#    define HttpLog(...) /* */
#endif


#if ERROR_LOGS == 1
#warning "ERROR_LOGS are ON - disable in release."
#    define ErrorLog(...) NSLog(__VA_ARGS__)
#else
#    define ErrorLog(...) /* */
#endif

#if DEBUG_LOGS == 1
#warning "DEBUG_LOGS are ON - disable in release."
#    define DLog(...) NSLog(__VA_ARGS__)
#else
#    define DLog(...) /* */
#endif


#if OPERATION_QUEUE_LOGS == 1
#warning "OPERATION_QUEUE_LOGS are ON - disable in release."
#    define OpQLog(...) NSLog(__VA_ARGS__)
#else
#    define OpQLog(...) /* */
#endif


#if ALLOC_LOGS == 1
#warning "ALLOC_LOGS are ON - disable in release."
#    define AllocLog(...) NSLog(__VA_ARGS__)
#else
#    define AllocLog(...) /* */
#endif


#if SUMMARY_LOGS == 1
#warning "SUMMARY_LOGS are ON - disable in release."
#    define SumLog(...) NSLog(__VA_ARGS__)
#else
#    define SumLog(...) /* */
#endif


#if NETWORK_LOGS == 1
#warning "NETWORK_LOGS are ON - disable in release."
#    define NetLog(...) NSLog(__VA_ARGS__)
#else
#    define NetLog(...) /* */
#endif


#if SOCIAL_LOGS == 1
#warning "SOCIAL_LOGS are ON - disable in release."
#    define SocLog(...) NSLog(__VA_ARGS__)
#else
#    define SocLog(...) /* */
#endif


#if APPLICATION_LOGS == 1
#warning "APPLICATION_LOGS are ON - disable in release."
#    define AppLog(...) NSLog(__VA_ARGS__)
#else
#    define AppLog(...) /* */
#endif

