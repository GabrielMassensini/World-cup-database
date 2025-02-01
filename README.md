# World Cup Database Project

Este projeto consiste em criar um banco de dados PostgreSQL para armazenar informações sobre os jogos das fases finais da Copa do Mundo desde 2014. O projeto é dividido em três partes principais: criação do banco de dados, inserção dos dados e consultas ao banco de dados.

## Estrutura do Projeto

O projeto é composto pelos seguintes arquivos:

- **games.csv**: Contém os dados dos jogos das fases finais da Copa do Mundo desde 2014.
- **insert_data.sh**: Script para inserir os dados do arquivo `games.csv` no banco de dados.
- **queries.sh**: Script para realizar consultas no banco de dados e gerar saídas específicas.
- **expected_output.txt**: Contém as saídas esperadas das consultas realizadas pelo script `queries.sh`.
- **worldcup.sql**: Dump do banco de dados gerado após a execução do script `insert_data.sh`.

## Como Executar o Projeto

### Pré-requisitos

- PostgreSQL instalado e configurado.
- Acesso ao terminal do PostgreSQL com o usuário `freecodecamp`.

### Passos para Execução

#### Criar o Banco de Dados e as Tabelas

Conecte-se ao PostgreSQL e crie o banco de dados e as tabelas necessárias:

```bash
psql --username=freecodecamp --dbname=postgres
```

Dentro do terminal interativo do PostgreSQL, execute:

```sql
CREATE DATABASE worldcup;
\c worldcup
```

Em seguida, crie as tabelas `teams` e `games`:

```sql
CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    round VARCHAR(50) NOT NULL,
    winner_id INT NOT NULL REFERENCES teams(team_id),
    opponent_id INT NOT NULL REFERENCES teams(team_id),
    winner_goals INT NOT NULL,
    opponent_goals INT NOT NULL
);
```

#### Inserir os Dados

Execute o script `insert_data.sh` para popular o banco de dados com os dados do arquivo `games.csv`:

```bash
./insert_data.sh
```

#### Realizar Consultas

Execute o script `queries.sh` para realizar as consultas no banco de dados e verificar se as saídas correspondem ao arquivo `expected_output.txt`:

```bash
./queries.sh
```

#### Salvar o Banco de Dados

Para salvar o banco de dados em um arquivo `.sql`, execute o seguinte comando:

```bash
pg_dump -cC --inserts -U freecodecamp worldcup > worldcup.sql
```

## Estrutura do Banco de Dados

### Tabela `teams`

- `team_id`: Identificador único do time (`SERIAL`, `PRIMARY KEY`).
- `name`: Nome do time (`VARCHAR(50)`, `UNIQUE`, `NOT NULL`).

### Tabela `games`

- `game_id`: Identificador único do jogo (`SERIAL`, `PRIMARY KEY`).
- `year`: Ano do jogo (`INT`, `NOT NULL`).
- `round`: Fase do jogo (`VARCHAR(50)`, `NOT NULL`).
- `winner_id`: ID do time vencedor (`INT`, `NOT NULL`, `FOREIGN KEY`).
- `opponent_id`: ID do time oponente (`INT`, `NOT NULL`, `FOREIGN KEY`).
- `winner_goals`: Número de gols do time vencedor (`INT`, `NOT NULL`).
- `opponent_goals`: Número de gols do time oponente (`INT`, `NOT NULL`).

## Consultas Realizadas

O script `queries.sh` realiza as seguintes consultas:

1. **Total de gols marcados pelos times vencedores em todos os jogos.**
2. **Total de gols marcados por ambos os times em todos os jogos.**
3. **Média de gols marcados pelos times vencedores em todos os jogos.**
4. **Média de gols marcados pelos times vencedores em todos os jogos, arredondada para duas casas decimais.**
5. **Média de gols marcados por ambos os times em todos os jogos.**
6. **Maior número de gols marcados por um time em um único jogo.**
7. **Número de jogos onde o time vencedor marcou mais de dois gols.**
8. **Nome do time vencedor da Copa do Mundo de 2018.**
9. **Lista dos times que jogaram na fase "Eighth-Final" em 2014.**
10. **Lista dos nomes únicos dos times vencedores em todo o conjunto de dados.**
11. **Ano e nome do time campeão em cada ano.**
12. **Lista dos times cujos nomes começam com "Co".**

## Como Contribuir

Se você quiser contribuir para este projeto, siga os passos abaixo:

1. **Faça um fork do repositório.**
2. **Crie uma branch para sua feature:**

   ```bash
   git checkout -b feature/nova-feature
   ```

3. **Commit suas mudanças:**

   ```bash
   git commit -m 'Adicionando nova feature'
   ```

4. **Push para a branch:**

   ```bash
   git push origin feature/nova-feature
   ```

5. **Abra um Pull Request.**

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## Nota

Certifique-se de que os scripts `insert_data.sh` e `queries.sh` tenham permissões de execução. Você pode conceder permissões de execução usando o comando:

```bash
chmod +x insert_data.sh queries.sh
```

