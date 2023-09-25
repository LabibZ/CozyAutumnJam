#ifndef MAP_H
#define MAP_H

#include <SFML/Graphics.hpp>
#include <vector>
#include "Table.h"

using namespace sf;

class Map{
    public:
        Map();
        void render(RenderWindow *screen);
        std::vector<IntRect> getCollisionRecs();
    private:
        Texture bgTexture{};
        Texture tableTexture{};
        Sprite bgSprite{};
        Vector2f scale{3.f, 3.f};
        std::vector<Table> tables{};
};

#endif