// AppDrawer.h — swipe-up app list, HarmonyOS-like column layout.
#pragma once
namespace etcpot {
class AppDrawer {
public:
    void Init();
    void Render(int w, int h);
    void OnTouch(int action, float x, float y);
    bool IsOpen() const { return open_; }
private:
    bool open_ = false;
};
}  // namespace etcpot
