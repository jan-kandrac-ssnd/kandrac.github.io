#!/usr/bin/env bash
set -e

REPO="git-rebase-cvicenie"
rm -rf "$REPO"
mkdir "$REPO"
cd "$REPO"

git init -q
git config user.name "Cvicenie"
git config user.email "cvicenie@example.com"

# --- 1. Init -------------------------------------------------------------
cat > kalkulacka.py <<'EOF'
def add(a, b):
    return a + b
EOF
git add kalkulacka.py
git commit -q -m "Init"

# Vetva pre neskorsi konflikt (kapitola 11) - odbocuje hned za "Init"
git branch feature/typovanie

# --- 2. Pridanie odcitania -------------------------------------------------
cat > subtract.py <<'EOF'
def subtract(a, b):
    return a - b
EOF
git add subtract.py
git commit -q -m "Pridanie odcitania"

# --- 3. Docasny debug subor - kandidat na "drop" --------------------------
cat > debug.py <<'EOF'
print("DEBUG: docasny vypis, zabudol som ho vymazat")
EOF
git add debug.py
git commit -q -m "docasny debug vypis"

# --- 4. Pridanie nasobenia - v sprave je preklep, kandidat na "reword" ----
cat > multiply.py <<'EOF'
def multiply(a, b):
    return a * b
EOF
git add multiply.py
git commit -q -m "pridanie funkcie nasobenie - preklep v sprave"

# --- 5. Zaciatok delenia (WIP) - kandidat na "squash" spolu s dalsim -----
cat > divide.py <<'EOF'
def divide(a, b):
    return a / b
EOF
git add divide.py
git commit -q -m "wip: zaciatok delenia"

# --- 6. Dokoncenie delenia (WIP) - squashne sa do predchadzajuceho commitu
cat > divide.py <<'EOF'
def divide(a, b):
    if b == 0:
        raise ValueError("Delenie nulou!")
    return a / b
EOF
git add divide.py
git commit -q -m "wip 2: osetrenie delenia nulou"

# --- 7. Hlavny subor - kandidat na "edit" (zabudnute testy) --------------
cat > main.py <<'EOF'
from kalkulacka import add
from subtract import subtract
from multiply import multiply
from divide import divide

if __name__ == "__main__":
    print(add(2, 3))
EOF
git add main.py
git commit -q -m "Pridanie hlavnej funkcie main"

# --- 8. Zmena signatury add() - vytvori konflikt s vetvou feature/typovanie
cat > kalkulacka.py <<'EOF'
def add(a: float, b: float) -> float:
    return a + b
EOF
git add kalkulacka.py
git commit -q -m "Pridanie typov k funkcii add (float)"

# --- Konfliktna vetva ------------------------------------------------------
git checkout -q feature/typovanie
cat > kalkulacka.py <<'EOF'
def add(a: int, b: int) -> int:
    return a + b
EOF
git add kalkulacka.py
git commit -q -m "Pridanie typov k funkcii add (int)"

git checkout -q main

echo ""
echo "Hotovo! Repozitar 'git-rebase-cvicenie' je pripraveny."
echo "Presun sa don prikazom: cd $REPO"
echo "Historiu si pozries pomocou: git log --oneline --all --graph"
