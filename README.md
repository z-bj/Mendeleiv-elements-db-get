![banner](https://github.com/z-bj/Mendeleiv-elements-db-get/blob/master/Mendeleev%20Table%20Database.jpg)

![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)![postgreSQL](https://camo.githubusercontent.com/281c069a2703e948b536500b9fd808cb4fb2496b3b66741db4013a2c89e91986/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f506f737467726553514c2d3331363139323f7374796c653d666f722d7468652d6261646765266c6f676f3d706f737467726573716c266c6f676f436f6c6f723d7768697465)![vim](https://img.shields.io/badge/Vim-019733.svg?style=for-the-badge&logo=Vim&logoColor=white)


## Project Goal
This Bash script is designed to retrieve information about chemical elements from a periodic table database. It allows you to search for an element by atomic number, symbol, or name and outputs information such as atomic mass, melting point, and boiling point.

## Project Goal

The goal of this project is to provide a user-friendly way to access information about chemical elements from the periodic table. The script connects to a periodic table database, fixes errors, and adds constraints and extra chemical element information. It then uses the Bash programming language to retrieve the requested element information and output it to the user.

## How to Use

To use this script, you'll need to have Bash installed on your computer. Once you have that, simply run the script with an argument in the form of an atomic number, symbol, or name of an element. For example:

``` bash

./periodic_table.sh 8

```

This will retrieve information about Oxygen, the element with an atomic number of 8.

If you're not sure what argument to use, you can simply run the script without an argument and it will prompt you to provide one:

``` bash

./periodic_table.sh

```

## Output

The script outputs information about the selected element in the following format:

``` bash

The element with atomic number [atomic number] is [name] ([symbol]). It's a [type], with a mass of [atomic mass] amu. [name] has a melting point of [melting point] celsius and a boiling point of [boiling point] celsius.

```

For example, if you search for Oxygen, the output will look like this:

``` bash

The element with atomic number 8 is Oxygen (O). It's a Nonmetal, with a mass of 15.999 amu. Oxygen has a melting point of -218.79 celsius and a boiling point of -182.962 celsius.

```

## Database

The script connects to a PostgreSQL database with the following credentials:

-   Username: freecodecamp
-   Database name: periodic_table

The database contains information about 118 chemical elements from the periodic table.

``` bash

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


```



<img src="https://github.com/z-bj/Periodic-table-database/blob/master/science_parrot.gif" width="36">
