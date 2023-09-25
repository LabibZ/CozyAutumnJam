#include "Table.h"

Table::Table(Vector2i pos) {
    position = pos;
    texture.loadFromFile("../src/assets/Map/table.png");
    sprite.setTexture(texture);
    sprite.setPosition(position.x, position.y);
    sprite.setScale(scale);
    size = {TABLE_WIDTH * scale.x, TABLE_HEIGHT * scale.y};
}

void Table::render(RenderWindow *screen){
    screen->draw(sprite);
}