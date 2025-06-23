#ifndef LADDER_HPP
#define LADDER_HPP

#include "../Engine/Tile.hpp"

/**
 * A climbable tile.
 */
class Ladder : public Tile
{
public:
	Ladder();

private:
	void onInit();
};

#endif // LADDER_HPP
