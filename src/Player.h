#ifndef PLAYER_H
#define PLAYER_H

#include <SFML/Graphics.hpp>

#define CHARACTER_HEIGHT 48
#define CHARACTER_WIDTH 32
#define IDLE_TEXTURE_HEIGHT 288
#define WALK_TEXTURE_HEIGHT 384

using namespace sf;

class Player 
{
public:
    Player();
    void update(float deltaTime);
    void move(Event event);
    void render(RenderWindow *screen, float deltaTime);
private:
    Texture idle{};
    Texture walk{};
    Texture texture{};
    Sprite sprite{};
    IntRect spriteSize{0, 0, CHARACTER_WIDTH, CHARACTER_HEIGHT};
    Vector2f velocity{};
    Vector2f position{};
    Vector2f scale{2.f, 2.f};
    float runningTime{};
    float updateTime{0.1f};
    float speed{20.f};
};

#endif