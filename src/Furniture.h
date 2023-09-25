#ifndef FURNITURE_H
#define FURNITURE_H

#include <SFML/Graphics.hpp>
#include <iostream>

using namespace sf;

class Furniture{
    public:
        IntRect getCollisionRec();
    protected:
        Sprite sprite{};
        Vector2i position{};
        Vector2f size{};
        Vector2f scale{3.0f, 3.0f};
};

#endif