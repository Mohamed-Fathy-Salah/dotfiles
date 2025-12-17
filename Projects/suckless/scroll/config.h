/*
 * Define ESC sequences to use for scroll events.
 * Use "cat -v" to figure out favorite key combination.
 *
 * lines is the number of lines scrolled up or down.
 * If lines is negative, it's the fraction of the terminal size.
 */

struct rule rules[] = {
    /* sequence     event        lines */
    {"\031", SCROLL_UP, 1},   /* mouse wheel up */
    {"\005", SCROLL_DOWN, 1}, /* mouse wheel Down */
    {"\013", SCROLL_UP, 1},    /* Ctrl + k (scroll up) */
    {"\012", SCROLL_DOWN, 1} /* Ctrl + j (scroll down) */
};
