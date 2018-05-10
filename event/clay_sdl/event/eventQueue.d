








module clay_sdl.event.eventQueue;

import cst_;
import xyz;


import derelict.sdl2.sdl	;

import clay_sdl.event.event	:	Event	;






class EventQueue {
	private {
		bool	isEventQueued	= false	;
		SDL_Event	queuedEvent		;
		////Window	window		;
		////void delegate(Size!(2,float))	resize_callback		;

		static Event convertEvent(SDL_Event event) {
			Event newEvent;
			if (event.type == SDL_QUIT) {
				newEvent.type = newEvent.Type.QUIT;
			}
			else if (event.type == SDL_KEYDOWN || event.type == SDL_KEYUP) {
				if (event.type == SDL_KEYDOWN)	{	newEvent.type = newEvent.Type.KEY_DOWN	;	}
				else	{	newEvent.type = newEvent.Type.KEY_UP	;	}
				
				with(newEvent.key) {
					windowId	= event.key.windowID	;
					pressed	= event.key.state == SDL_RELEASED	;
					repeat	= event.key.repeat	;
					scancode	= event.key.keysym.scancode.cst!(uint).cst!(Event.KeyEvent.Scancode)	;
					keycode	= event.key.keysym.sym.cst!(uint).cst!(Event.KeyEvent.Keycode)	;
					mod	= event.key.keysym.mod	;
				}
			}
			////else if (event.type == SDL_MOUSEMOTION) {
			////    newEvent.type = newEvent.Type.TEXT_EDITING	;
			////
			////    with(newEvent.textEditing) {
			////        windowId	= event.key.windowID	;
			////        pressed	= event.key.state == SDL_RELEASED	;
			////        repeat	= event.key.repeat	;
			////        scancode	= event.key.keysym.scancode	;
			////        keycode	= event.key.keysym.sym	;
			////        mod	= event.key.keysym.mod	;
			////    }
			////}
			else if (event.type == SDL_WINDOWEVENT) {
				newEvent.type	= newEvent.Type.WINDOW_EVENT	;

				with (newEvent.window) {
					windowId	= event.window.windowID	;
					type	= event.window.event.cst!Type	;

					if (type == Type.MOVED || type == Type.RESIZED) {
						pos = [event.window.data1, event.window.data2];
					}
				}
			}
			return newEvent;
		}
	}

	public {
		this (){////dsfml.window.Window dsfml_window, void delegate(Size!(2,float)) resize_callback) {
			////this.dsfml_window	= dsfml_window	;
			////this.resize_callback	= resize_callback	;
		}

		bool empty() {
			if (!isEventQueued) {
				isEventQueued = SDL_PollEvent(&queuedEvent).cst!bool;
			}
			return !isEventQueued;
		}
		Event front() {
			assert(this.isEventQueued, "Must check `empty` before calling `front`");
			////if (queuedEvent.type == queuedEvent.EventType.Resized) {
			////   this.resize_callback([queuedEvent.size.width.cst!float, queuedEvent.size.height.cst!float]);
			////}
			return convertEvent(queuedEvent);
		}
		void popFront() {
			this.isEventQueued = false;
		}
	}
}

