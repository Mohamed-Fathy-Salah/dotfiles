#include "../theme.h"

static const char *background_color = BG_COLOR;
static const char *border_color = FG_COLOR;
static const char *font_color = "#ececec";
static const char *font_pattern = "SauceCodePro Nerd Font:pixelsize=16:antialias=true:autohint=true" ;
static const unsigned line_spacing = 5;
static const unsigned int padding = 15;

static const unsigned int width = 350;
static const unsigned int border_size = 2;
static const unsigned int pos_x = 30;
static const unsigned int pos_y = 60;

enum corners { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT };
enum corners corner = TOP_RIGHT;

static const unsigned int duration = 3; /* in seconds */

#define DISMISS_BUTTON Button1
#define ACTION_BUTTON Button3
