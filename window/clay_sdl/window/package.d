/**
The Window submodule of clay_sdl.  The base for every part.



*/


module clay_sdl.window;

public import clay_sdl.window.setup_gl;


import std.stdio;


import cst_;
import xyz;

import gl_context;

import derelict.sdl2.sdl	;
import std.string	: toStringz;



/**	Initialize SDL*/
static this () {
	DerelictSDL2.load();
	// Initialise SDL
	if (SDL_Init(SDL_INIT_VIDEO) != 0) {
		writeln("SDL_Init: ", SDL_GetError());
	}
}
/**	Release SDL.  (Release memory, etc)*/
static ~this () {
	"sdl ~this".writeln;
	SDL_Quit();
}











class Window {
	/**	Init Window with default position.
	*/
	this (string title, int[2] size, Flags flags=cst!Flags(0)) {
		this(title, [SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED], size, flags);
	}
	/**	Init Window with explicit position.
	*/
	this (string title, int[2] pos, int[2] size, Flags flags=cst!Flags(0)) {
		title.writeln;

		// Create a window
		sdl_window = SDL_CreateWindow	(	title.toStringz	,
				pos.x	,
				pos.y	,
				size.x	,
				size.y	,
				cst!SDL_WindowFlags(cst!uint(flags))	,
			);
	}
	/**	Release Window.  (Release memory, etc)*/
	~this () {
		if (sdl_window !is null) {
			SDL_DestroyWindow(sdl_window);
		}
	}
	

	SDL_Window* sdl_window;
	
	
	
	public {
		void* createGlContext(){
			return SDL_GL_CreateContext(sdl_window);
		}
		GLContext createGLContext(){
			void* context = SDL_GL_CreateContext(sdl_window);
			return GLContext(context, (){SDL_GL_MakeCurrent(sdl_window, context);}, (){SDL_GL_SwapWindow(sdl_window);});
		}
		void resize(int[2] size) {
			sdl_window.SDL_SetWindowSize(size.x,size.y);
		}
	}
	
	
	
	

	
	enum Flags : uint {
		FULLSCREEN	=	SDL_WINDOW_FULLSCREEN	,	/**	fullscreen window	*/
		Fullscreen	=	SDL_WINDOW_FULLSCREEN	,	/**	ditto	*/
		OPENGL	=	SDL_WINDOW_OPENGL	,	/**	window usable with OpenGL context	*/
		OpenGL	=	SDL_WINDOW_OPENGL	,	/**	ditto	*/
		SHOWN	=	SDL_WINDOW_SHOWN	,	/**	window is visible	*/
		Shown	=	SDL_WINDOW_SHOWN	,	/**	ditto	*/
		HIDDEN	=	SDL_WINDOW_HIDDEN	,	/**	window is not visible	*/
		Hidden	=	SDL_WINDOW_HIDDEN	,	/**	ditto 	*/
		BORDERLESS	=	SDL_WINDOW_BORDERLESS	,	/**	no window decoration 	*/
		Borderless	=	SDL_WINDOW_BORDERLESS	,	/**	ditto 	*/
		RESIZABLE	=	SDL_WINDOW_RESIZABLE	,	/**	window can be resized 	*/
		Resizable	=	SDL_WINDOW_RESIZABLE	,	/**	ditto 	*/
		MINIMIZED	=	SDL_WINDOW_MINIMIZED	,	/**	window is minimized 	*/
		Minimized	=	SDL_WINDOW_MINIMIZED	,	/**	ditto 	*/
		MAXIMIZED	=	SDL_WINDOW_MAXIMIZED	,	/**	window is maximized 	*/
		Mamimized	=	SDL_WINDOW_MAXIMIZED	,	/**	ditto 	*/
		INPUT_GRABBED	=	SDL_WINDOW_INPUT_GRABBED	,	/**	window has grabbed input focus 	*/
		InputGrabbed	=	SDL_WINDOW_INPUT_GRABBED	,	/**	ditto 	*/
		INPUT_FOCUS	=	SDL_WINDOW_INPUT_FOCUS	,	/**	window has input focus 	*/
		InputFocus	=	SDL_WINDOW_INPUT_FOCUS	,	/**	ditto 	*/
		MOUSE_FOCUS	=	SDL_WINDOW_MOUSE_FOCUS	,	/**	window has mouse focus 	*/
		MouseFocus	=	SDL_WINDOW_MOUSE_FOCUS	,	/**	ditto 	*/
		FULLSCREEN_DESKTOP	=	SDL_WINDOW_FULLSCREEN_DESKTOP	,
		FullscreenDeskton	=	SDL_WINDOW_FULLSCREEN_DESKTOP	,
		FOREIGN	=	SDL_WINDOW_FOREIGN	,	/**	window not created by SDL 	*/
		Foreign	=	SDL_WINDOW_FOREIGN	,	/**	ditto 	*/
		ALLOW_HIGH_DPI	=	SDL_WINDOW_ALLOW_HIGHDPI	,	/**	window should be created in high-DPI mode if supported 	*/
		AllowHighDPI	=	SDL_WINDOW_ALLOW_HIGHDPI	,	/**	ditto 	*/
		MOUSE_CAPTURE	=	SDL_WINDOW_MOUSE_CAPTURE	,	/**	window has mouse captured (unrelated to INPUT_GRABBED)	*/
		MouseCapture	=	SDL_WINDOW_MOUSE_CAPTURE	,	/**	ditto	*/
		ALWAYS_ON_TOP	=	SDL_WINDOW_ALWAYS_ON_TOP	,	/**	window should always be above others 	*/
		AlwaysOnTop	=	SDL_WINDOW_ALWAYS_ON_TOP	,	/**	ditto 	*/
		SKIP_TASKBAR	=	SDL_WINDOW_SKIP_TASKBAR	,	/**	window should not be added to the taskbar 	*/
		SkipTaskbar	=	SDL_WINDOW_SKIP_TASKBAR	,	/**	ditto 	*/
		UTILITY	=	SDL_WINDOW_UTILITY	,	/**	window should be treated as a utility window 	*/
		Utility	=	SDL_WINDOW_UTILITY	,	/**	ditto 	*/
		TOOLTIP	=	SDL_WINDOW_TOOLTIP	,	/**	window should be treated as a tooltip 	*/
		Tooltip	=	SDL_WINDOW_TOOLTIP	,	/**	ditto 	*/
		POPUP_MENU	=	SDL_WINDOW_POPUP_MENU	,	/**	window should be treated as a popup menu 	*/
		PopupMenu	=	SDL_WINDOW_POPUP_MENU	,	/**	ditto 	*/
		////VULKAN	=	SDL_WINDOW_VULKAN	,	/**	window usable for Vulkan surface 	*/
	}
	
	
	
	
	
	
	
	
}






