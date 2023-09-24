#include "Game.h"

// Static Functions


// Init Functions
void Game::InitWindow()
{
	window = new sf::RenderWindow(sf::VideoMode(1280, 720), "SFML works!");
}

// Constructurs/Destructors
Game::Game()
{
    InitWindow();
}

Game::~Game()
{
	delete window;
}

// Functions
/* Amount of time for Update() and Render() in one frame. */
void Game::UpdateDeltaTime()
{
    deltaTime = deltaTimeClock.restart().asSeconds();
}

void Game::UpdateSFMLEvents()
{
    while (window->pollEvent(event))
    {
        if (event.type == sf::Event::Closed)
            window->close();
    }

}

void Game::Update()
{
    UpdateSFMLEvents();

}

void Game::Render()
{
    window->clear();

    // Render Items

    window->display();
}

void Game::Run()
{
    while (window->isOpen())
    {
        UpdateDeltaTime();
        Update();
        Render();
    }
}
