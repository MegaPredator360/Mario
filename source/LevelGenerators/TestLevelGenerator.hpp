#ifndef TESTLEVELGENERATOR_HPP
#define TESTLEVELGENERATOR_HPP

#include "../Utils/LevelGenerator.hpp"

/**
 * Generates a test Level.
 */
class TestLevelGenerator : public LevelGenerator
{
public:
	Level* generateLevel( int seed ) const;
};

#endif // TESTLEVELGENERATOR_HPP
