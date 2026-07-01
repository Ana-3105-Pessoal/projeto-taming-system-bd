# ARK Taming System — Banco de Dados Relacional

Modelagem e implementação de um banco de dados relacional inspirado no sistema de domesticação de criaturas do jogo *Ark: Survival Ascended*.

---

## Objetivo

Projetar, modelar e implementar um banco de dados relacional completo, cobrindo desde o levantamento de requisitos até a implementação SQL com controle transacional.

---

## Estrutura do Projeto

```
projeto-taming-system-bd/
├── docs/
│   ├── modelo_conceitual.png              # Modelo Entidade-Relacionamento
│   ├── modelo_logico.png              # Modelo Lógico
│   └── relatorio.pdf        # Relatório técnico completo
├── sql/
│   └── SQLProjetoFinal.sql           # Script de criação e inserção
└── README.md
```

---

## Entidades

| Tabela | Descrição |
|---|---|
| `tribe` | Tribos formadas por jogadores |
| `player` | Jogadores do servidor |
| `creature` | Criaturas existentes no mundo |
| `specie` | Espécies com atributos biológicos |
| `map` | Mapas e biomas disponíveis |
| `item` | Itens usados no processo de domesticação |
| `mutation` | Tipos de mutação genética |
| `domestication` | Evento de domesticação — entidade associativa entre Player e Creature |
| `creature_mutation` | Mutações adquiridas por uma criatura — associativa entre Creature e Mutation |
| `spawn_rate` | Frequência de spawn por espécie e mapa — associativa entre Specie e Map |
| `inventory` | Inventário de itens por jogador — associativa entre Player e Item |

---

## Dados inseridos

| Tabela | Registros |
|---|---|
| `specie` | 16 |
| `map` | 9 |
| `tribe` | 3 |
| `item` | 21 |
| `player` | 7 |
| `creature` | 2 |
| `spawn_rate` | 10 |
| `domestication` | 1 |
| `inventory` | 9 |
| **Total** | **~76** |

---

## Decisoes de Modelagem

- Relacionamentos N:N resolvidos com entidades associativas (`domestication`, `creature_mutation`, `spawn_rate`, `inventory`)
- Chaves primarias compostas declaradas nas tabelas associativas via `ALTER TABLE ... ADD CONSTRAINT ... PRIMARY KEY`
- Restrições CHECK em `level`, `status`, `diet`, `method`, `difficulty`, `rarity`, `biome`, `frequency` e `attribute`
- UNIQUE aplicado em `username`, e nos atributos `name` de `tribe`, `specie`, `map` e `item`
- `health` e `stamina` presentes tanto em `player` quanto em `creature`, refletindo a mecanica de progressao de atributos por nivel do jogo
- Restrições de `biome` e `type`/`rarity` de item foram refinadas via `ALTER TABLE` durante a implementacao, ao perceber que mapas como *Aberration* e *Extinction* possuem ambientacoes que nao se encaixavam nos biomas inicialmente definidos — decisao documentada no relatorio tecnico

---

## Controle Transacional

O script inclui um bloco transacional (`BEGIN` / `COMMIT`) cobrindo o processo completo de domesticacao: registro do evento em `domestication`, atualizacao do `status` da criatura para `tamed` e renomeacao do individuo — garantindo que as tres operacoes sejam atomicas.

---

## Tecnologias

- PostgreSQL
- BrModelo (modelagem conceitual e logica)
- Overleaf / LaTeX (relatorio tecnico)

---

## Disciplina

**Banco de Dados I** — 3º Semestre  
Centro Universitario SENAC (UNISENAC) — 2026

## Licença

Este projeto está sob a licença MIT — veja o arquivo [LICENSE](LICENSE) para mais detalhes.