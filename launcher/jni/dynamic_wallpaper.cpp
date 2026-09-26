// DynamicWallpaper.cpp — aurora shader: two moving radial gradients on a
// dark blue background, matching HarmonyOS NEXT "流影" wallpaper.
#include "dynamic_wallpaper.h"
namespace etcpot {
void DynamicWallpaper::Init() {
    // Compile fragment shader:
    //   vec2 uv = gl_FragCoord.xy / u_res;
    //   float d1 = distance(uv, vec2(0.5+0.3*sin(u_t), 0.5+0.2*cos(u_t*0.7)));
    //   ... add radial glow, noise, and vignette.
}
void DynamicWallpaper::Render(int w, int h) {
    t_ += 0.005f;
    glViewport(0, 0, w, h);
    glClearColor(0.05f, 0.07f, 0.15f, 1.f);
    glClear(GL_COLOR_BUFFER_BIT);
    // In production: draw fullscreen quad with aurora fragment shader.
}
}  // namespace etcpot
