//
//  Constants.h
//  Picket
//
//  Created by Jay Quiambao on 1/8/14.
//  Copyright (c) 2014 Internet Brands. All rights reserved.
//

/*
 App Config
 */

#define APP_NAME                        @"[AppName]"

/*
 DEVELOPMENT/DEBUG
 */
#define DEV_SKIP_PIN                NO
#define DEV_SKIP_NETWORK            NO
#define DEV_USE_DEMO_USER           NO
#define DEV_SKIP_USER_PERSISTENCE   NO
#define DEV_SKIP_APNS               NO
#define DEV_ALL_AVAILABLE           NO

/*
 LOGGING
 */
#define DEV_SHOW_API_METHOD_LOG     0
#define DEV_SHOW_API_REQUEST_LOG    0
#define DEV_SHOW_API_RESPONSE_LOG   0

/*
 API
*/
#if !defined(STAGING)
    #define PROJECT_URL    @"https://api.github.com"
#elif STAGING == 1
    #define PROJECT_URL    @"https://api.github.com"
#endif

#define VERSION                     @"2"
#define API_VERSION                 [NSString stringWithFormat:@"/cines/cliente_smartphone/v%@", VERSION]
#define BASE_URL                    [NSURL URLWithString:[NSString stringWithFormat:@"%@", PROJECT_URL]]

/*
 SYSTEM SETTINGS
*/
#define SECURE_ACCESS_TIMEOUT_IN_MINUTES 15
#define SECURE_LAST_ACCESS_DATE         @"SECURE_LAST_ACCESS_DATE"
#define OAUTH_SIGNATURE_METHOD          @"PLAINTEXT"
#define MAX_PIN_ATTEMPTS                5

/*
 USER DEFAULTS
 */
#define PERSISTENCE_ENCODED_USER                    @"PERSISTENCE_ENCODED_USER"
#define PERSISTENCE_SETTINGS_ANALYTICS_DEFAULT      @"PERSISTENCE_SETTINGS_ANALYTICS_DEFAULT"
#define PERSISTENCE_SETTINGS_TOGGLE_NOTIFICATIONS   @"PERSISTENCE_SETTINGS_TOGGLE_NOTIFICATIONS"
#define PERSISTENCE_OAUTH_CONSUMER_KEY              @"PERSISTENCE_OAUTH_CONSUMER_KEY"
#define PERSISTENCE_OAUTH_SIGNATURE                 @"PERSISTENCE_OAUTH_SIGNATURE"
#define PERSISTENCE_OAUTH_TOKEN                     @"PERSISTENCE_OAUTH_TOKEN"
#define PERSISTENCE_USER_LOGIN_STATUS               @"PERSISTENCE_USER_LOGIN_STATUS"
#define PERSISTENCE_USER_USERNAME                   @"PERSISTENCE_USER_USERNAME"
#define PERSISTENCE_USER_PASSWORD                   @"PERSISTENCE_USER_PASSWORD"
#define PERSISTENCE_USER_DEVICE_TOKEN               @"PERSISTENCE_USER_DEVICE_TOKEN"

/*
FONTS AND THEME
 */
#define FONT_NAME_REGULAR               @"HelveticaNeue"
#define FONT_NAME_MEDIUM                @"HelveticaNeue-Medium"
#define FONT_NAME_BOLD                  @"HelveticaNeue-Bold"
#define FONT_NAME_THIN                  @"HelveticaNeue-Thin"
#define FONT_NAME_LIGHT                 @"HelveticaNeue-Light"
#define FONT_NAME_ULTRALIGHT            @"HelveticaNeue-UltraLight"

#define SYSTEM_ALPHA                    0.40f
#define CYAN_COLOR                      @"1BD0B9"
#define CYAN_LIGHT_COLOR                @"86f6e8"
#define BLUE_COLOR                      @"1E3B65"
#define GREEN_COLOR                     @"03e94f"
#define GRAY_COLOR                      @"B5B5B6"
#define LIGHT_GRAY_COLOR                @"C2C2C2"
#define DARK_GRAY_COLOR                 @"3B3B3B"
#define BLACK_COLOR                     @"494949"
#define DEBUG_COLOR                     @"FF0000"
#define BLUE_FADED_COLOR                @"68ADE7"

#define STANDARD_TEXT_COLOR             BLACK_COLOR
#define STANDARD_TEXT_GRAY_COLOR        GRAY_COLOR

//common
#define NAVIGATION_BAR_COLOR            @"0477D7"
#define SEGMENTED_SELECTED_COLOR        @"8BCAFE"
#define CELL_SELECTED_COLOR             @"f3f2f2"

#define NAVIGATION_BAR_GRAD_COLOR1      @"ff7c1648"
#define NAVIGATION_BAR_GRAD_COLOR2      @"ffd0187d"
#define NAVIGATION_BAR_GRAD_COLOR3      @"ffea188d"

#define _SEGMENTED_SELECTED_COLOR        @"8BCAFE"
#define _CELL_SELECTED_COLOR             @"f3f2f2"



//analytics
#define ANALYTICS_EXTENDED_BAR_COLOR            NAVIGATION_BAR_COLOR
#define ANALYTICS_SEGMENTED_SELECTED_COLOR      SEGMENTED_SELECTED_COLOR

//login
#define LOGIN_BUTTON_COLOR                CYAN_COLOR
#define LOGIN_BUTTON_SELECTED_COLOR       CYAN_LIGHT_COLOR
//menu
#define MENU_ITEM_COLOR                 @"B6CDE6"

//dashboard
#define DASHBOARD_BADGE_COLOR           CYAN_COLOR
#define DASHBOARD_ANNOUNCEMENT_COLOR    BLUE_COLOR

//review
#define REVIEW_SOCIAL_NETWORK_COLOR     CYAN_COLOR
#define REVIEW_TABLE_HEADER_COLOR       BLUE_COLOR
#define REVIEW_DATE_COLOR               STANDARD_TEXT_GRAY_COLOR
#define REVIEW_FILTER_SEPARATOR_COLOR   @"5A5959"
#define REVIEW_FILTER_CANCEL_TEXT_COLOR @"2181F7"

//suport
#define SUPPORT_STATUS_TEXT_COLOR       GREEN_COLOR
#define SUPPORT_SUBJECT_TEXT_COLOR      DARK_GRAY_COLOR
#define SUPPORT_DATE_TEXT_COLOR         LIGHT_GRAY_COLOR

//apointment
#define APPOINTMENT_CIRLCE_COLOR                    CYAN_LIGHT_COLOR
#define APPOINTMENT_GRAY_COLOR                      STANDARD_TEXT_GRAY_COLOR
#define APPOINTMENT_BUTTON_COLOR                    CYAN_COLOR
#define APPOINTMENT_CALL_BUTTON_SELECTED_COLOR      CYAN_LIGHT_COLOR
#define APPOINTMENT_EMAIL_BUTTON_SELECTED_COLOR     @"30717d"

//social
#define TWITTER_FOLOWERS_LABEL_COLOR            @"7e92a8"

//stats
#define STATS_CELL_NAME_COLOR           STANDARD_TEXT_COLOR
#define STATS_CELL_VALUE_COLOR          STANDARD_TEXT_COLOR

//keyword ranking
#define KEYWORD_RANKING_SUBTITLE_COLOR  BLUE_FADED_COLOR
#define KEYWORD_RANKING_KEYWORD_COLOR   STANDARD_TEXT_COLOR
#define KEYWORD_RANKING_RANK_COLOR      STANDARD_TEXT_COLOR


/*
 CHART COLORS
 */
#define PIE_CHART_SLICE_COLOR_BLUE      @"02DAFC"
#define PIE_CHART_SLICE_COLOR_RED       @"FE6764"
#define PIE_CHART_SLICE_COLOR_YELLOW    @"FCF902"
#define PIE_CHART_SLICE_COLOR_GREEN     @"25FD02"
#define PIE_CHART_SLICE_COLOR_PURPLE    @"FB6AF9"


/*
 UTILITIES
 */
#define DEVICE_SYSTEM_VERSION                           [[[UIDevice currentDevice] systemVersion] floatValue]
#define DEVICE_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL(x)  DEVICE_SYSTEM_VERSION >= x? YES: NO

#define IS_4_INCH_SCREEN                                (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define SCREEN_WIDTH                                    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT                                   [[UIScreen mainScreen] bounds].size.height
#define IS_OS_5_OR_LATER                                (DEVICE_SYSTEM_VERSION >= 5.0)
#define IS_OS_6_OR_LATER                                (DEVICE_SYSTEM_VERSION >= 6.0)
#define IS_OS_7_OR_LATER                                (DEVICE_SYSTEM_VERSION >= 7.0)
#define IS_OS_BEFORE_7                                  (DEVICE_SYSTEM_VERSION < 7.0)

/*
 MISC
 */
// top section height
#define DETAIL_VIEW_MAX_HEIGHT  577
#define IPHONE4INCH_HEIGHT      568
#define STATUS_BAR_HEIGHT       20
#define NAVIGATION_BAR_HEIGHT   44
#define TOP_SECTION_HEIGHT      (STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)
#define TABBAR_SECTION_HEIGHT   28

#define GLOBAL_HEIGHT_NAV      (IS_OS_7_OR_LATER) ? TOP_SECTION_HEIGHT : NAVIGATION_BAR_HEIGHT

