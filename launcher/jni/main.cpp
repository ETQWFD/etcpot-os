// EtcPotLauncher — NativeActivity entry point.
//
// The launcher is a single EGL surface that owns:
//   * a Workspace (paged home screens, icon grid)
//   * an AppDrawer (swipe-up list of all installed apps)
//   * a DynamicWallpaper (animated GL background)
//
// Gestures (tap / long-press / pinch / swipe) are handled in on_input_event.

#include <android/native_activity.h>
#include <android/input.h>
#include <EGL/egl.h>
#include <GLES3/gl3.h>
#include <gui/BufferQueue.h>
#include <gui/Surface.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "workspace.h"
#include "app_drawer.h"
#include "dynamic_wallpaper.h"

namespace etcpot {

struct LauncherState {
    EGLDisplay display = EGL_NO_DISPLAY;
    EGLSurface surface = EGL_NO_SURFACE;
    EGLContext context = EGL_NO_CONTEXT;
    EGLConfig  config = nullptr;
    int32_t width = 0;
    int32_t height = 0;

    Workspace      workspace;
    AppDrawer      drawer;
    DynamicWallpaper wallpaper;
    bool           running = true;
};

static void glue_init_display(LauncherState* s) {
    EGLint attribs[] = {
        EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
        EGL_RENDERABLE_TYPE, EGL_OPENGL_ES3_BIT,
        EGL_RED_SIZE, 8, EGL_GREEN_SIZE, 8, EGL_BLUE_SIZE, 8, EGL_ALPHA_SIZE, 8,
        EGL_NONE
    };
    EGLint numConfigs = 0;
    s->display = eglGetDisplay(EGL_DEFAULT_DISPLAY);
    eglInitialize(s->display, nullptr, nullptr);
    eglChooseConfig(s->display, attribs, &s->config, 1, &numConfigs);
    EGLint fmt[] = { EGL_NONE };
    eglGetConfigAttrib(s->display, s->config, EGL_NATIVE_VISUAL_ID, &fmt[0]);
    EGLint ctxAttr[] = { EGL_CONTEXT_CLIENT_VERSION, 3, EGL_NONE };
    s->context = eglCreateContext(s->display, s->config, EGL_NO_CONTEXT, ctxAttr);
}

static void glue_render(LauncherState* s) {
    s->wallpaper.Render(s->width, s->height);
    s->workspace.Render(s->width, s->height);
    if (s->drawer.IsOpen()) s->drawer.Render(s->width, s->height);
    eglSwapBuffers(s->display, s->surface);
}

static int32_t on_input_event(ANativeActivity*, void* user, AInputEvent* ev) {
    auto* s = reinterpret_cast<LauncherState*>(user);
    int type = AInputEvent_getType(ev);
    if (type == AINPUT_EVENT_TYPE_MOTION) {
        int action = AMotionEvent_getAction(ev) & AMOTION_EVENT_ACTION_MASK;
        float x = AMotionEvent_getX(ev, 0);
        float y = AMotionEvent_getY(ev, 0);
        if (s->drawer.IsOpen()) s->drawer.OnTouch(action, x, y);
        else                    s->workspace.OnTouch(action, x, y);
    }
    return 0;
}

static void on_content_rect_changed(ANativeActivity*, void* user,
                                    int32_t, int32_t, int32_t w, int32_t h) {
    auto* s = reinterpret_cast<LauncherState*>(user);
    s->width = w; s->height = h;
    if (s->surface != EGL_NO_SURFACE)
        eglDestroySurface(s->display, s->surface);
    s->surface = eglCreateWindowSurface(s->display, s->config,
                                        s->activity->window, nullptr);
    eglMakeCurrent(s->display, s->surface, s->surface, s->context);
}

static void on_destroy(ANativeActivity* act) {
    auto* s = reinterpret_cast<LauncherState*>(act->userData);
    s->running = false;
    eglMakeCurrent(s->display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
    eglDestroyContext(s->display, s->context);
    eglTerminate(s->display);
    delete s;
}

}  // namespace etcpot

extern "C" void ANativeActivity_onCreate(ANativeActivity* act, void*, size_t) {
    using namespace etcpot;
    auto* s = new LauncherState();
    s->activity = act;
    act->userData = s;
    act->callbacks->onInputContentRectChanged = on_content_rect_changed;
    act->callbacks->onNativeInputEvent       = on_input_event;
    act->callbacks->onDestroy                 = on_destroy;
    glue_init_display(s);
    s->wallpaper.Init();
    s->workspace.Init();
    s->drawer.Init();

    // Main render loop (in production this runs on a dedicated thread).
    while (s->running) {
        glue_render(s);
    }
}
