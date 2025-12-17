// See LICENSE file for copyright and license details. */
#include "../theme.h"
#include <X11/XF86keysym.h>

#define TERMINAL "st"
/* apkpearance */
static const unsigned int borderpx = 1; /* border pixel of windows */
static const unsigned int snap = 32;    /* snap pixel */
static const int showbar = 1;           /* 0 means no bar */
static const int topbar = 1;            /* 0 means bottom bar */
static const char *fonts[] = {
    "SauceCodePro Nerd Font:pixelsize=16:antialias=true:autohint=true"};

static const char normfgcolor[] = "#ebdbb2";
static const char normbgcolor[] = BG_COLOR;
static const char normbordercolor[] = "#000000";
static const char selfgcolor[] = FG_COLOR;
static const char selbgcolor[] = BG_COLOR;
static const char selbordercolor[] = FG_COLOR;
static const char *colors[][3] = {
    /*                fg            bg              border           */
    [SchemeNorm] = {normfgcolor, normbgcolor, normbordercolor},
    [SchemeSel] = {selfgcolor, selbgcolor, selbordercolor},
    //[SchemeTitle] = { titlefgcolor, titlebgcolor,   titlebordercolor },
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     iscentered   isfloating   monitor */
    {"Chromium", NULL, NULL, 1 << 0, 0, 0, 0},
    {"mpv", NULL, NULL, 1 << 1, 0, 0, 0},
    {"copyq", NULL, NULL, 0, 1, 1, -1},
    {"DBeaver", NULL, NULL, 1 << 2, 0, 0, 1},
    {"Java", NULL, "Dbeaver", 1 << 2, 1, 0, 1},
    {"st-256color", NULL, "qalc", 0, 1, 1, -1},
    {"st-256color", NULL, "alsamixer", 0, 1, 1, -1},
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    1; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */

    {"  ", tile}, /* first entry is default */
    {" ", bstack},
    {"  ", NULL}, /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALT Mod1Mask

#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ALT, KEY, tag, {.ui = 1 << TAG}},

#define STACKKEYS(MOD, ACTION)                                                 \
  {MOD, XK_l, ACTION##stack, {.i = INC(+1)}},                                  \
      {MOD, XK_h, ACTION##stack, {.i = INC(-1)}},

#define STATUSBAR "dwmblocks"

// static char dmenumon[2] = "0";
// static const char *dmenucmd[] = { "dmenu_run", "-fn", dmenufont, "-nb",
// normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL
 //};
//static const char *dmenucmd[] = { "dmenu_run"};

static Key keys[] = {
    /* modifier                     key        function        argument */
    STACKKEYS(MODKEY, focus) STACKKEYS(MODKEY | ALT, push)

        TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
            TAGKEYS(XK_5, 4)

                {MODKEY, XK_q, killclient, {0}},

    {MODKEY | ALT, XK_t, setlayout, {.v = &layouts[0]}}, /* tile */
    {MODKEY | ALT, XK_b, setlayout, {.v = &layouts[1]}}, /* bstack */
    {MODKEY | ALT, XK_f, setlayout, {.v = &layouts[2]}}, /* float */
    {0, XK_F11, togglefullscr, {0}},

    {MODKEY | ALT, XK_i, incnmaster, {.i = +1}},
    {MODKEY | ALT, XK_u, incnmaster, {.i = -1}},

    {MODKEY, XK_i, setmfact, {.f = +0.05}},
    {MODKEY, XK_u, setmfact, {.f = -0.05}},

    {MODKEY, XK_j, shiftview, {.i = -1}},
    {MODKEY, XK_k, shiftview, {.i = +1}},
    {MODKEY | ALT, XK_j, shifttag, {.i = -1}},
    {MODKEY | ALT, XK_k, shifttag, {.i = +1}},

    {MODKEY, XK_b, togglebar, {0}},

    {MODKEY, XK_e, zoom, {0}},
    {MODKEY, XK_n, focusmon, {.i = +1}},
    {MODKEY | ALT, XK_n, tagmon, {.i = +1}},
    //{ MODKEY|ShiftMask,	XK_f,	togglefloating,	{0} },

    //{ 0,				            XK_Print,  spawn,	       SHCMD("maim
    //~/pictures/pic-full-$(date '+%y%m%d-%H%M-%S').png ;cat
    //~/pictures/pic-full-$(date '+%y%m%d-%H%M-%S').png | xclip -selection
    //clipboard -t image/png") }, { ALT,      		            XK_Print,
    //spawn,		   SHCMD("maim -i $(xdotool getactivewindow)
    //~/pictures/pic-full-$(date '+%y%m%d-%H%M-%S').png ;cat
    //~/pictures/pic-full-$(date '+%y%m%d-%H%M-%S').png | xclip -selection
    //clipboard -t image/png") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function argument */
    //{ ClkLtSymbol,          0,              Button1,        setlayout, {0} },
    //{ ClkLtSymbol,          0,              Button3,        setlayout, {.v =
    //&layouts[2]} }, { ClkWinTitle,          0,              Button2, zoom, {0}
    //}, { ClkStatusText,        0,              Button2,        spawn, {.v =
    //termcmd } },
    {ClkStatusText, 0, Button1, sigstatusbar, {.i = 1}},
    {ClkStatusText, 0, Button3, sigstatusbar, {.i = 3}},
    {ClkStatusText, 0, Button4, sigstatusbar, {.i = 4}},
    {ClkStatusText, 0, Button5, sigstatusbar, {.i = 5}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, 0, Button4, shiftview, {.i = +1}},
    {ClkTagBar, 0, Button5, shiftview, {.i = -1}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
    {ClkClientWin, ALT, Button4, shifttag, {.i = +1}},
    {ClkClientWin, ALT, Button5, shifttag, {.i = -1}},
};
