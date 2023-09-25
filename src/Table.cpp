#include "Table.h"

Table::Table(Texture texture, Vector2i pos) {
    position = pos;
    sprite.setTexture(texture);
    sprite.setPosition(position.x, position.y);
    sprite.setScale(scale);
    size = {TABLE_WIDTH * scale.x, TABLE_HEIGHT * scale.y};
}

void Table::render(RenderWindow *screen){
    screen->draw(sprite);
}