module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

secondsPerEarthYear :: Float
secondsPerEarthYear = 31557600.0

orbitalPeriodFactor :: Planet -> Float
orbitalPeriodFactor Earth = 1 
orbitalPeriodFactor Mercury = 0.2408467 
orbitalPeriodFactor Venus = 0.61519726 
orbitalPeriodFactor Mars = 1.8808158 
orbitalPeriodFactor Jupiter = 11.862615 
orbitalPeriodFactor Saturn = 29.447498 
orbitalPeriodFactor Uranus = 84.016846 
orbitalPeriodFactor Neptune = 164.789132 

ageOn :: Planet -> Float -> Float
ageOn p seconds = seconds / (secondsPerEarthYear * orbitalPeriodFactor p)
