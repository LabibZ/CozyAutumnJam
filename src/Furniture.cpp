#include "Furniture.h"

IntRect Furniture::getCollisionRec(){
    return IntRect(position.x, position.y, size.x, size.y);
}