#include "Player.h"
#include <iostream>

using namespace std; 

Player::Player()
{
    idle.loadFromFile("../src/assets/witch/B_witch_idle.png");
    walk.loadFromFile("../src/assets/witch/B_witch_run.png");
    sprite.setTexture(idle);
    sprite.setTextureRect(spriteSize);
    sprite.setScale(scale);
}

IntRect Player::getCollisionRec(){
    return IntRect(position.x, position.y, CHARACTER_WIDTH * scale.x, CHARACTER_HEIGHT * scale.y);
}

void Player::update(float deltaTime, std::vector<IntRect> recs){
    Vector2f lastPos = position;

    position += velocity * deltaTime;

    if (
        position.x < WINDOW_LEFT ||  
        position.y < WINDOW_TOP ||
        position.x + (CHARACTER_WIDTH * scale.x) > WINDOW_RIGHT ||
        position.y + (CHARACTER_HEIGHT * scale.y) > WINDOW_BOTTOM
    )
    {
            position = lastPos;
    }
    for (auto rec: recs){
        if (rec.intersects(getCollisionRec())){
            std::cout << "Collision detected!" << std::endl;
            position = lastPos;
        }
    }

    sprite.setPosition(position);
}

void Player::move(Event event){
    if (event.type == Event::KeyPressed){
        switch(event.key.code){
            case(Keyboard::W):
                velocity.y = speed * -1.f;
                break;
            case(Keyboard::S):
                velocity.y = speed;
                break;
            case(Keyboard::A):
                velocity.x = speed * -1.f;
                break;
            case(Keyboard::D):
                velocity.x = speed;
                break;
        }
    }
    if (event.type == Event::KeyReleased){
        switch(event.key.code){
            case(Keyboard::W):
            case(Keyboard::S):
                velocity.y = 0.f;
                break;
            case(Keyboard::A):
            case(Keyboard::D):
                velocity.x = 0.f;
                break;
        }
    }
}

void Player::render(RenderWindow *screen, float deltaTime){
    if (velocity.x == 0 && velocity.y == 0){
        sprite.setTexture(idle);
    }
    else{
        sprite.setTexture(walk);
    }
    
    runningTime += deltaTime;
    if (runningTime > updateTime){
      if (spriteSize.top + CHARACTER_HEIGHT >= IDLE_TEXTURE_HEIGHT)
        spriteSize.top = 0;
      else
        spriteSize.top += CHARACTER_HEIGHT;

      sprite.setTextureRect(spriteSize);
      runningTime = 0;
    }

    screen->draw(sprite);
}