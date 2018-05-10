


module clay_sdl.window.setup_gl;

import cst_;
import xyz;

import derelict.sdl2.sdl	;




static class SetupGl {
	static:
	
	int[2] ver(int major, int minor) {
		return	[	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, major),
				SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, minor),	]; 
	}
	
	static class ContextProfileMask {
		static:
		int core()	{	return SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);	}
		int compatibility()	{	return SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_COMPATIBILITY);	}
		int es()	{	return SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_ES);	}
	}
}
