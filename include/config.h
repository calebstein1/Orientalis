#ifndef UNTITLED_PLATFORMER_CONFIG_H
#define UNTITLED_PLATFORMER_CONFIG_H

#include "engine/util.h"

#define GAME_TITLE "Orientalis"
#define GAME_AUTHOR "Syoma Codes"

#define FRAMERATE 60
#define WINDOW_X 1280
#define WINDOW_Y 720

/*
 * fullscreen: display fullscreen
 * fixed: window size fixed to WINDOW_X * WINDOW_Y
 * resizable: default window size of WINDOW_X * WINDOW_Y
 */
#define WINDOW_MODE fixed

/* Map actions to keys here following the example in the comment */
#define DEFAULT_KEYMAP \
	/* KMAP(action, keys, controller) */ \
	KMAP(left, a, DPAD_LEFT) \
	KMAP(right, d, DPAD_RIGHT) \
	KMAP(up, w, DPAD_UP) \
	KMAP(down, s, DPAD_DOWN) \
	KMAP(attack, SPACE, A) \
	KMAP(menu, LSHIFT, B)

#endif /* UNTITLED_PLATFORMER_CONFIG_H */
