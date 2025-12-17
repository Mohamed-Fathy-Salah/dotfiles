#define CMDLENGTH 100
#define DELIMITER " ┃ "
#define CLICKABLE_BLOCKS

const Block blocks[] = {
	BLOCK("sb-date",    0,    1),
	BLOCK("sb-time",    60,   2),
	BLOCK("sb-memory",  0,    3),
	BLOCK("sb-mixer",  0,    6),
	BLOCK("sb-network", 5,    9),
	BLOCK("sb-lang",    0,    8),
};
