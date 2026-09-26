// Workspace.cpp — paged home screen, icon grid, long-press edit.
#pragma once
#include <GLES3/gl3.h>
#include <vector>
#include <string>

namespace etcpot {

struct AppIcon {
    std::string package;
    std::string label;
    float x, y;       // grid position in cells
    GLuint texture;   // loaded from APK icon
};

class Workspace {
public:
    void Init();
    void Render(int w, int h);
    void OnTouch(int action, float x, float y);

private:
    std::vector<AppIcon> icons_;
    int   pages_       = 3;
    int   currentPage_ = 0;
    float scrollX_     = 0.f;
};

}  // namespace etcpot
