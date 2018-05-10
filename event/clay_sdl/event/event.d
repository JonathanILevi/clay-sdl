/*
Largely copied from SDL source.  SDL Lisence header below.
*/
/*
Simple DirectMedia Layer
Copyright (C) 1997-2018 Sam Lantinga <slouken@libsdl.org>

This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
claim that you wrote the original software. If you use this software
in a product, an acknowledgment in the product documentation would be
appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
*/

module clay_sdl.event.event;

struct  Event {
	enum Type : uint {
		UNKNOWN     = 0,     /**	Was `UNUSED` in SDL*/

		/* Application events */
		QUIT           = 0x100,	/**	User-requested quit */

		/* These application events have special meaning on iOS, see README-ios.md for details */
		APP_TERMINATING,	/**	The application is being terminated by the OS
				Called on iOS in applicationWillTerminate()
		Called on Android in onDestroy()
		*/
		APP_LOW_MEMORY,	/**	The application is low on memory, free memory if possible.
				Called on iOS in applicationDidReceiveMemoryWarning()
		Called on Android in onLowMemory()
		*/
		APP_WILL_ENTER_BACKGROUND,	/**	The application is about to enter the background
				Called on iOS in applicationWillResignActive()
		Called on Android in onPause()
		*/
		APP_DId_ENTER_BACKGROUND,	/**	The application did enter the background and may not get CPU for some time
				Called on iOS in applicationDidEnterBackground()
		Called on Android in onPause()
		*/
		APP_WILL_ENTER_FOREGROUND,	/**	The application is about to enter the foreground
				Called on iOS in applicationWillEnterForeground()
		Called on Android in onResume()
		*/
		APP_DId_ENTER_FOREGROUND,	/**	The application is now interactive
				Called on iOS in applicationDidBecomeActive()
		Called on Android in onResume()
		*/

		/* Window events */
		WINDOW_EVENT    = 0x200,	/**	Window state change */
		SYSWM_EVENT,	/**	System specific event */

		/* Keyboard events */
		KEY_DOWN        = 0x300,	/**	Key pressed */
		KEY_UP,	/**	Key released */
		TEXT_EDITING,	/**	Keyboard text editing (composition) */
		TEXT_INPUT,	/**	Keyboard text input */
		KEY_MAP_CHANGED,	/**	Keymap changed due to a system event such as an
				input language or keyboard layout change.
		*/

		/* Mouse events */
		MOUSE_MOTION    = 0x400,	/**	Mouse moved */
		MOUSE_BUTTON_DOWN,	/**	Mouse button pressed */
		MOUSE_BUTTON_UP,	/**	Mouse button released */
		MOUSE_WHEEL,	/**	Mouse wheel motion */

		/* Joystick events */
		JOY_AXIS_MOTION  = 0x600,	/**	Joystick axis motion */
		JOY_BALL_MOTION,	/**	Joystick trackball motion */
		JOY_HAT_MOTION,	/**	Joystick hat position change */
		JOY_BUTTON_DOWN,	/**	Joystick button pressed */
		JOY_BUTTON_UP,	/**	Joystick button released */
		JOY_DEVICE_ADDED,	/**	A new joystick has been inserted into the system */
		JOY_DEVICE_REMOVED,	/**	An opened joystick has been removed */

		/* Game controller events */
		CONTROLLER_AXIS_MOTION  = 0x650,	/**	Game controller axis motion */
		CONTROLLER_BUTTON_DOWN,	/**	Game controller button pressed */
		CONTROLLER_BUTTON_UP,	/**	Game controller button released */
		CONTROLLER_DEVICE_ADDED,	/**	A new Game controller has been inserted into the system */
		CONTROLLER_DEVICE_REMOVED,	/**	An opened Game controller has been removed */
		CONTROLLER_DEVICE_REMAPPED,	/**	The controller mapping was updated */

		/* Touch events */
		FINGER_DOWN      = 0x700,
		FINGER_UP,
		FINGER_MOTION,

		/* Gesture events */
		DOLLAR_GESTURE   = 0x800,
		DOLLAR_RECORD,
		MULTIGESTURE,

		/* Clipboard events */
		CLIPBOARD__UPDATE = 0x900,	/**	The clipboard changed */

		/* Drag and drop events */
		DROP_FILE        = 0x1000,	/**	The system requests a file open */
		DROP_TEXT,	/**	text/plain drag-and-drop event */
		DROP_BEGIN,	/**	A new set of drops is beginning (NULL filename) */
		DROP_COMPLETE,	/**	Current set of drops is now complete (NULL filename) */

		/* Audio hotplug events */
		AUDIO_DEVICE_ADDED = 0x1100,	/**	A new audio device is available */
		AUDIO_DEVICE_REMOVED,	/**	An audio device has been removed. */

		/* Render events */
		RENDER_TARGETS_RESET = 0x2000,	/**	The render targets have been reset and their contents need to be updated */
		RENDER_DEVICE_RESET,	/**	The device has been reset and all textures need to be recreated */

		/** Events ::USEREVENT through ::LASTEVENT are for your use,
		*  and should be allocated with RegisterEvents()
		*/
		USER_EVENT    = 0x8000,

		/**	This last event is only for bounding internal arrays
		*/
		LAST_EVENT    = 0xFFFF
	}

	/**	Fields shared by every event
	*/
	uint type;
	uint timestamp;   /**	In milliseconds, populated using GetTicks() */

	/**	Window state change event data (event.window.*)
	*/
	struct  WindowEvent	{	uint	windowId;	/**	The associated window	*/
			Type	type;	/**	::WindowEventId	*/
			union {
				int[2]	pos	;
				int[2]	size	;
			}
			
			
			enum Type : uint {
				UNKNOWN	,	/**	Was `NONE` in SDL	*/
				SHOWN	,	/**	Window has been shown	*/
				HIdDEN	,	/**	Window has been hidden	*/
				EXPOSED	,	/**	Window has been exposed and should be	
							redrawn	*/
				MOVED	,	/**	Window has been moved to data1, data2	*/
				RESIZED	,	/**	Window has been resized to data1, data2	*/
				SIZE_CHANGED	,	/**	The window size has changed, either as	
							a result of an API call or through the	
							system or user changing the window size.	*/
				MINIMIZED	,	/**	Window has been minimized	*/
				MAXIMIZED	,	/**	Window has been maximized	*/
				RESTORED	,	/**	Window has been restored to normal size	
							and position	*/
				ENTER	,	/**	Window has gained mouse focus	*/
				LEAVE	,	/**	Window has lost mouse focus	*/
				FOCUS_GAINED	,	/**	Window has gained keyboard focus	*/
				FOCUS_LOST	,	/**	Window has lost keyboard focus	*/
				CLOSE	,	/**	The window manager requests that the window be closed	*/
				TAKE_FOCUS	,	/**	Window is being offered a focus (should SetWindowInputFocus() on itself or a subwindow, or ignore)	*/
				HIT_TEST	,	/**	Window had a hit test that wasn't SDL_HITTEST_NORMAL.	*/
			}
		}
	
	/**	Keyboard button event struct ure (event.key.*)
	*/
	struct KeyEvent	{	public import clay_sdl.event.keyboard : Scancode,Keycode;
		
			uint	windowId;	/**	The window with keyboard focus, if any	*/
			bool	pressed;	/**	PRESSED or RELEASED	*/
			ubyte	repeat;	/**	Non-zero if this is a key repeat	*/
			Scancode	scancode;
			Keycode	keycode;
			ushort	mod;
		}

	/////**	Keyboard text editing event struct ure (event.edit.*)
	////*/
	////struct TextEditingEvent	{	uint windowId;	/**	The window with keyboard focus, if any	*/
	////        char text[TEXTEDITINGEVENT_TEXT_SIZE];	/**	The editing text	*/
	////        int start;	/**	The start cursor of selected editing text	*/
	////        int length;	/**	The length of selected editing text	*/
	////    }

	/////**	Keyboard text input event struct ure (event.text.*)
	////*/
	////struct TextInputEvent	{	uint windowId;	/**	The window with keyboard focus, if any	*/
	////        char text[TEXTINPUTEVENT_TEXT_SIZE];	/**	The input text	*/
	////    }

	/**	Mouse motion event struct ure (event.motion.*)
	*/
	struct MouseMotionEvent	{	uint windowId;	/**	The window with mouse focus, if any	*/
			uint which;	/**	The mouse instance id, or TOUCH_MOUSEId	*/
			uint state;	/**	The current button state	*/
			int[2] pos;	/**	Mouse position relative to window	*/
			int[2] rel;	/**	The relative motion	*/
		}

	/**	Mouse button event struct ure (event.button.*)
	*/
	struct MouseButtonEvent	{	uint windowId;	/**	The window with mouse focus, if any	*/
			uint which;	/**	The mouse instance id, or TOUCH_MOUSEId	*/
			ubyte button;	/**	The mouse button index	*/
			bool state;	/**	PRESSED or RELEASED	*/
			ubyte clicks;	/**	1 for single-click, 2 for double-click, etc.	*/
			int[2] pos;	/**	Click position relative to window	*/
		}

	/**	Mouse wheel event struct ure (event.wheel.*)
	*/
	struct MouseWheelEvent	{	uint windowId;	/**	The window with mouse focus, if any	*/
			uint which;	/**	The mouse instance id, or TOUCH_MOUSEId	*/
			int[2] amount;	/**	The amount scrolled horizontally, positive to the right and negative to the left
					The amount scrolled vertically, positive away from the user and negative toward the user	*/
			uint direction;	/**	Set to one of the MOUSEWHEEL_* defines. When FLIPPED the values in X and Y will be opposite. Multiply by -1 to change them back	*/
		}

	/////**	Joystick axis motion event struct ure (event.jaxis.*)
	////*/
	////struct JoyAxisEvent	{	JoystickId which;	/**	The joystick instance id	*/
	////        ubyte axis;	/**	The joystick axis index	*/
	////        short value;	/**	The axis value (range: -32768 to 32767)	*/
	////    }
	////
	/////**	Joystick trackball motion event struct ure (event.jball.*)
	////*/
	////struct JoyBallEvent	{	JoystickId which;	/**	The joystick instance id	*/
	////        ubyte ball;	/**	The joystick trackball index	*/
	////        short xrel;	/**	The relative motion in the X direction	*/
	////        short yrel;	/**	The relative motion in the Y direction	*/
	////    }
	////
	/////**	Joystick hat position change event struct ure (event.jhat.*)
	////*/
	////struct JoyHatEvent	{	JoystickId which;	/**	The joystick instance id	*/
	////        ubyte hat;	/**	The joystick hat index	*/
	////        byte[2] position;	/**	The x and y of the hat position; 0=centered, -1=up|left, 1=down|right	*/
	////    }
	////
	/////**	Joystick button event struct ure (event.jbutton.*)
	////*/
	////struct JoyButtonEvent	{	JoystickId which;	/**	The joystick instance id	*/
	////        ubyte button;	/**	The joystick button index	*/
	////        ubyte state;	/**	PRESSED or RELEASED	*/
	////    }
	////
	/////**	Joystick device event struct ure (event.jdevice.*)
	////*/
	////struct JoyDeviceEvent	{	int which;	/**	The joystick device index for the ADDED event, instance id for the REMOVED event	*/
	////    }
	////
	/////**	Game controller axis motion event struct ure (event.caxis.*)
	////*/
	////struct ControllerAxisEvent	{	JoystickId which;	/**	The joystick instance id	*/
	////        ubyte axis;	/**	The controller axis (GameControllerAxis)	*/
	////        short value;	/**	The axis value (range: -32768 to 32767)	*/
	////    }
	////
	/////**	Game controller button event struct ure (event.cbutton.*)
	////*/
	////struct ControllerButtonEvent	{	JoystickId which;	/**	The joystick instance id	*/
	////        ubyte button;	/**	The controller button (GameControllerButton)	*/
	////        ubyte state;	/**	PRESSED or RELEASED	*/
	////    }
	////
	/////**	Controller device event struct ure (event.cdevice.*)
	////*/
	////struct ControllerDeviceEvent	{	int which;	/**	The joystick device index for the ADDED event, instance id for the REMOVED or REMAPPED event	*/
	////    }
	////
	/////**	Audio device event struct ure (event.adevice.*)
	////*/
	////struct AudioDeviceEvent	{	uint which;	/**	The audio device index for the ADDED event (valid until next GetNumAudioDevices() call), AudioDeviceId for the REMOVED event	*/
	////        ubyte iscapture;	/**	zero if an output device, non-zero if a capture device.	*/
	////    }

	/////**	Touch finger event struct ure (event.tfinger.*)
	////*/
	////struct TouchFingerEvent	{	TouchId touchId;	/**	The touch device id	*/
	////        FingerId fingerId;
	////        float x;	/**	Normalized in the range 0...1	*/
	////        float y;	/**	Normalized in the range 0...1	*/
	////        float dx;	/**	Normalized in the range -1...1	*/
	////        float dy;	/**	Normalized in the range -1...1	*/
	////        float pressure;	/**	Normalized in the range 0...1	*/
	////    }
	////
	/////**	Multiple Finger Gesture Event (event.mgesture.*)
	////*/
	////struct MultiGestureEvent	{	TouchId touchId;	/**	The touch device id	*/
	////        float dTheta;
	////        float dDist;
	////        float x;
	////        float y;
	////        ushort numFingers;
	////    }
	////
	/////**	Dollar Gesture Event (event.dgesture.*)
	////*/
	////struct DollarGestureEvent	{	TouchId touchId;	/**	The touch device id	*/
	////        GestureId gestureId;
	////        uint numFingers;
	////        float error;
	////        float[] center;	/**	Normalized center of gesture	*/
	////    }

	/////**	An event used to request a file open by the system (event.drop.*)
	////    This event is enabled by default, you can disable it with EventState().
	////    note: If this event is enabled, you must free the filename in the event.
	////*/
	////struct DropEvent	{	string file;	/**	The file name, which should be freed with free(), is NULL on begin/complete	*/
	////        uint windowId;	/**	The window that was dropped on, if any	*/
	////    }

	/**	The "quit requested" event
	*/
	struct QuitEvent	{	uint windowId	;	/**	This may be inaccurate if only one window has been opened	*/
		}
	
	/**	OS Specific event
	*/
	struct OSEvent	{	
		}

	/////**	A user-defined event type (event.user.*)
	////*/
	////struct UserEvent	{	uint windowId;	/**	The associated window if any	*/
	////        int code;	/**	User defined event code	*/
	////        void *data1;	/**	User defined data pointer	*/
	////        void *data2;	/**	User defined data pointer	*/
	////    }
	////
	/////**	A video driver dependent system event (event.syswm.*)
	////    This event is disabled by default, you can enable it with EventState()
	////    
	////    note: If you want to use this event, you should include syswm.h.
	////*/
	////struct SysWMEvent	{	SysWMmsg *msg;	/**	driver dependent data, defined in syswm.h	*/
	////	}
	
	/**	General event struct ure
	*/
	union {
		QuitEvent quit;	/**	Quit request event data */
		WindowEvent window;	/**	Window event data */
		KeyEvent key;	/**	Keyboard event data */
		////TextEditingEvent textEditing;	/**	Text editing event data */
		////TextInputEvent textInput;	/**	Text input event data */
		MouseMotionEvent mouseMotion;	/**	Mouse motion event data */
		MouseButtonEvent mouseButton;	/**	Mouse button event data */
		MouseWheelEvent mouseWheel;	/**	Mouse wheel event data */
		////JoyAxisEvent jaxis;	/**	Joystick axis event data */
		////JoyBallEvent jball;	/**	Joystick ball event data */
		////JoyHatEvent jhat;	/**	Joystick hat event data */
		////JoyButtonEvent jbutton;	/**	Joystick button event data */
		////JoyDeviceEvent jdevice;	/**	Joystick device change event data */
		////ControllerAxisEvent caxis;	/**	Game Controller axis event data */
		////ControllerButtonEvent cbutton;	/**	Game Controller button event data */
		////ControllerDeviceEvent cdevice;	/**	Game Controller device event data */
		////AudioDeviceEvent adevice;	/**	Audio device event data */
		////UserEvent user;	/**	Custom event data */
		////SysWMEvent syswm;	/**	System dependent window event data */
		////TouchFingerEvent tfinger;	/**	Touch finger event data */
		////MultiGestureEvent mgesture;	/**	Gesture event data */
		////DollarGestureEvent dgesture;	/**	Gesture event data */
		////DropEvent drop;	/**	Drag and drop event data */
	}

}

