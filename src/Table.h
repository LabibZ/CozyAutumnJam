#ifndef TABLE_H
#define TABLE_H

#include "Furniture.h"

#define TABLE_WIDTH 32
#define TABLE_HEIGHT 48

using namespace sf;

class Table : public Furniture{
    public:
        Table(Texture texture, Vector2i pos);
        void render(RenderWindow *screen);
};

#endif