#include "Player.h"

Player::Player()
{
    idle.loadFromFile("../src/assets/witch/B_witch_idle.png");
    walk.loadFromFile("../src/assets/witch/B_witch_run.png");
    sprite.setTexture(idle);
    sprite.setTextureRect(spriteSize);
    sprite.setScale(scale);
}

void Player::update(float deltaTime){
    position += velocity * deltaTime;
    sprite.setPosition(position);
}

void Player::move(Event event){
    if (event.type == Event::KeyPressed){
        switch(event.key.code){
            case(Keyboard::W):
                velocity.y = speed * -1.f;
            case(Keyboard::S):
                velocity.y = speed;
            case(Keyboard::A):
                velocity.x = speed * -1.f;
            case(Keyboard::D):
                velocity.x = speed;
        }
    }
    if (event.type == Event::KeyReleased){
        switch(event.key.code){
            case(Keyboard::W):
            case(Keyboard::S):
                velocity.y = 0.f;
            case(Keyboard::A):
            case(Keyboard::D):
                velocity.x = 0.f;
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