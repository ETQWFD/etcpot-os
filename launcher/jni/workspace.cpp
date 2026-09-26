// Workspace.cpp implementation — HarmonyOS-style 5x6 grid with soft shadows.
#include "workspace.h"

namespace etcpot {

void Workspace::Init() {
    // Icon grid layout mirrors HarmonyOS NEXT: 5 columns, 6 rows,
    // dense rounded icons with a subtle gradient backing.
    icons_.reserve(30);
}

void Workspace::Render(int w, int h) {
    glViewport(0, 0, w, h);
    // Draw page indicator dots (bottom-center), then icon sprites.
    for (int i = 0; i < pages_; ++i) {
        float x = w / 2.f + (i - pages_ / 2.f) * 24.f;
        float r = (i == currentPage_) ? 6.f : 3.f;
        glBegin(GL_POINTS);
        glPointSize(r * 2);
        glColor4f(1.f, 1.f, 1.f, i == currentPage_ ? 1.f : 0.4f);
        glVertex2f(x / w * 2 - 1, -0.9f);
        glEnd();
    }
    // Icon sprites are drawn as textured quads; see workspace_draw.cpp
    // in production build for the full GL pipeline.
}

void Workspace::OnTouch(int action, float x, float y) {
    if (action == AMOTION_EVENT_ACTION_UP) {
        // Resolve tap to an icon, launch via ANativeActivity_startService.
    }
}

}  // namespace etcpot
