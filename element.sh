#!/bin/bash

# Create a PSQL variable to query the periodic table database
PSQL="psql -x --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# Check if an element is provided as an argument
if [[ -z $1 ]]
then
# If no element is provided, ask the user to provide one
echo "Please provide an element as an argument."

else
# If an element is provided

bash
Copy code
# Check if it is not a number 
if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    # Search the element by name or symbol
    GET_ELEMENT_SELECTED=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol ILIKE '$1' OR name ILIKE '$1'")
  
  else
    # Search the element by atomic_number
    GET_ELEMENT_SELECTED=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number)INNER JOIN types USING(type_id) WHERE atomic_number=$1")
fi

# Check if the element is not found
if [[ -z $GET_ELEMENT_SELECTED ]]
  then
    # If the element is not found, inform the user
    echo "I could not find that element in the database."
  
  else
    # If the element is found, output its information
    echo $GET_ELEMENT_SELECTED | while read COL BAR ATOMIC_NUMBER COL BAR NAME COL BAR SYMBOL COL BAR TYPE COL BAR ATOMIC_MASS COL BAR MELTING_POINT COL BAR BOILING_POINT
    do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done

fi
fi
