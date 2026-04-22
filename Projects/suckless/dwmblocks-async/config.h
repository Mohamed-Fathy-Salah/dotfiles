// add 34 to the signal number 
// kill -34+i $(pidof dwmblocks)
#ifndef CONFIG_H
#define CONFIG_H

// String used to delimit block outputs in the status.
#define DELIMITER " ┃ "

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 45

// Control whether blocks are clickable.
#define CLICKABLE_BLOCKS 1

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X)                   \
	X(" ", "sb-date",    0,    1)  \
	X("", "sb-time",    60,   2)    \
	X("", "sb-memory",  0,    3)    \
	X("", "sb-mixer",  0,    6)     \
	X("", "sb-network", 5,    9)    \
	X("", "sb-lang",    0,    8)

#endif  // CONFIG_H
