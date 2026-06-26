# 🦖 ARK Taming System — Banco de Dados Relacional

Projeto final da disciplina **Banco de Dados I** — Análise e Desenvolvimento de Sistemas | UNISENAC  
Modelagem e implementação de um banco de dados relacional inspirado no sistema de domesticação de criaturas do jogo *Ark: Survival Ascended*.

---

## 📌 Objetivo

Projetar, modelar e implementar um banco de dados relacional completo, cobrindo desde o levantamento de requisitos até a implementação SQL com controle transacional.

---

## 🧩 Entidades

| Tabela | Descrição |
|---|---|
| `Tribe` | Tribos formadas por jogadores |
| `Player` | Jogadores do servidor |
| `Creature` | Criaturas existentes no mundo |
| `Specie` | Espécies com atributos biológicos |
| `Map` | Mapas e biomas disponíveis |
| `Item` | Itens usados no processo de domesticação |
| `Mutation` | Tipos de mutação genética |
| `Domestication` | Evento de domesticação (Player + Creature) |
| `Creature_mutation` | Mutações adquiridas por uma criatura |
| `Spawn_rate` | Frequência de spawn por espécie e mapa |
| `Inventory_stores` | Inventário de itens por jogador |

---

## 📐 Decisões de Modelagem

- **Referências N:N** resolvidas com entidades associativas (`Domestication`, `Creature_mutation`, `Spawn_rate`, `Inventory_stores`)
- **Restrições CHECK** em atributos como `level`, `status`, `diet`, `method`, `difficulty` e `rarity`
- **UNIQUE** aplicado em nomes de entidades principais (`username`, `name` em Tribe/Specie/Map/Item)
- `health` e `stamina` presentes tanto em `Player` quanto em `Creature`, refletindo a mecânica de progressão de atributos por nível do jogo

---

## 🛠️ Tecnologias

- PostgreSQL
- BrModelo (modelagem conceitual e lógica)
- Overleaf/LaTeX (relatório técnico)

---

## 📚 Disciplina

**Banco de Dados I** — 3º Semestre  
Centro Universitário SENAC (UNISENAC) — 2026
