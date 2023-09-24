#ifndef GAME_H
#define GAME_H

#include <iostream>
#include <ctime>
#include <cstdlib>

#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
// TODO: add network later

class Game
{
private:
	sf::RenderWindow* window;
	sf::Event event;

	sf::Clock deltaTimeClock;
	float deltaTime;

	// Init
	void InitWindow();

public:
	// Constructurs/Destructors
	Game();
	virtual ~Game();

	// Functions
	void UpdateDeltaTime();
	void UpdateSFMLEvents();
	void Update();
	void Render();
	void Run();
};

#endif // GAME_H