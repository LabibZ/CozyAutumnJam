#include "Map.h"

Map::Map(){
    bgTexture.loadFromFile("../src/assets/Map/bg.png");
    bgSprite.setTexture(bgTexture);
    bgSprite.setScale(scale);

    tables.push_back(Table({350, 400}));
    tables.push_back(Table({600, 250}));
}

void Map::render(RenderWindow *screen){
    screen->draw(bgSprite);

    for (unsigned int i = 0; i < tables.size(); i++){
        tables[i].render(screen);
    }
}

std::vector<IntRect> Map::getCollisionRecs(){
    std::vector<IntRect> recs;

    for (unsigned int i = 0; i < tables.size(); i++){
        recs.push_back(tables[i].getCollisionRec());
    };
    
    return recs;
}