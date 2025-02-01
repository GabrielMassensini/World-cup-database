#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Ler o arquivo CSV e ignorar o cabeçalho
tail -n +2 games.csv | while IFS=',' read -r year round winner opponent winner_goals opponent_goals
do
    # Inserir o time vencedor se não existir
    $PSQL "INSERT INTO teams(name) SELECT '$winner' WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = '$winner')"
    # Inserir o time oponente se não existir
    $PSQL "INSERT INTO teams(name) SELECT '$opponent' WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = '$opponent')"
    # Obter os IDs dos times
    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner'")
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent'")
    # Inserir o jogo
    $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals)"
done