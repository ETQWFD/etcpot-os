// DynamicWallpaper.h — animated GL background (flowing aurora gradients).
#pragma once
namespace etcpot {
class DynamicWallpaper {
public:
    void Init();
    void Render(int w, int h);
private:
    float t_ = 0.f;
    GLuint program_ = 0;
};
}  // namespace etcpot
