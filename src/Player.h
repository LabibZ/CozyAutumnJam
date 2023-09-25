#ifndef PLAYER_H
#define PLAYER_H

#include <SFML/Graphics.hpp>
#include <vector>

#define CHARACTER_HEIGHT 48
#define CHARACTER_WIDTH 32
#define IDLE_TEXTURE_HEIGHT 288
#define WALK_TEXTURE_HEIGHT 384

#define WINDOW_TOP 128
#define WINDOW_BOTTOM 690
#define WINDOW_LEFT 24
#define WINDOW_RIGHT 880

using namespace sf;

class Player 
{
public:
    Player();
    void update(float deltaTime, std::vector<IntRect> recs);
    void move(Event event);
    void render(RenderWindow *screen, float deltaTime);
    IntRect getCollisionRec();
private:
    Texture idle{};
    Texture walk{};
    Texture texture{};
    Sprite sprite{};
    IntRect spriteSize{0, 0, CHARACTER_WIDTH, CHARACTER_HEIGHT};
    Vector2f velocity{};
    Vector2f position{100.f, 150.f};
    Vector2f scale{3.f, 3.f};
    float runningTime{};
    float updateTime{0.1f};
    float speed{150.f};
};

#endif