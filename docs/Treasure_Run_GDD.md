# Game Design Document: Treasure Run

## 1. Executive Summary
**Treasure Run** ist ein rasanter 2D-Platformer für mobile Endgeräte. Der Spieler steuert einen Charakter aus der Seitenansicht durch blockbasierte Level, sammelt Ressourcen, weicht tödlichen Gefahren aus und bekämpft Monster, um den rettenden Ausgang zu erreichen. Das Spiel kombiniert klassisches Jump'n'Run-Gameplay mit Ressourcenmanagement (Munition) und taktischem Vorgehen.

> **Vision Statement:** Ein zugängliches, aber forderndes Mobile-Game, das präzises Platforming und schnelles Reagieren in kurzen, intensiven Spielesessions belohnt.

---

### 1.1 Projektdaten & Rahmenbedingungen
* **Genre:** 2D Action-Platformer / Side-Scroller
* **Plattform:** Mobile (Fokus Android)
* **Engine:** Godot 4.x (GDScript)
* **Status:** MVP Planung (Soll-Ist Plan)
* **Entwicklungsbudget:** ca. 30 Stunden

---

## 2. Zielgruppenanalyse
Das Spiel ist massgeschneidert für den mobilen Spielemarkt und richtet sich an folgende Zielgruppe:

* **Demografie:** Casual bis Mid-Core Gamer, Alter 12–35 Jahre.
* **Spielverhalten:** Typische Mobile-Gaming-Szenarien (Pendeln, Wartezeiten, kurze Pausen). Gewünscht sind kurze, knackige Sessions von 2 bis 5 Minuten pro Level.
* **Motivation:** Schnelle Action, direkter Spieleinstieg ohne langes Tutorial, Highscore-Jagd oder Level-Abschluss als Belohnung.
* **Anforderung an das Design:** Klare visuelle Kontraste (auf kleinen Smartphone-Bildschirmen gut lesbar), einfache und fehlerverzeihende Touch-Steuerung, sofortiges Feedback bei Aktionen.

---

## 3. Gameplay & Mechaniken

### 3.1 Core Loop (Kernschleife)
Die Kernschleife von *Treasure Run* besteht aus:
1. **Navigieren** durch das Level (Springen von Block zu Block).
2. **Einsammeln** von Kisten (Loot), um Munition und den Schlüssel zu finden.
3. **Bekämpfen** oder Ausweichen von Monstern.
4. **Erfüllen** der Siegbedingungen, um den Ausgang freizuschalten.

### 3.2 Steuerung (Touchscreen-Layout)
Die Steuerung ist strikt auf Touch-Displays optimiert. Ein "On-Screen"-Overlay bietet folgende Interaktionen:
* **Linke Bildschirmhälfte (Daumen-Steuerung):** Virtuelle Tasten oder eine Wisch-Geste zur horizontalen Bewegung nach links und rechts.
* **Rechte Bildschirmhälfte:** Zwei gut erreichbare, separate Action-Buttons:
  * **Jump (Springen):** Zum Überwinden von Abgründen und Erreichen höherer Blöcke.
  * **Shoot (Schiessen):** Zum Abfeuern von Projektilen auf Monster.

### 3.3 Spieler-Interaktionen & Sammelobjekte
In der Spielwelt sind Kisten verteilt, die der Spieler durch Berührung oder Angriff öffnen kann. Sie enthalten essenzielle Gegenstände:

| Item | Funktion & Auswirkung auf das Gameplay | Status |
| :--- | :--- | :--- |
| **Munition** | Füllt den begrenzten Vorrat an Schüssen auf. Zwingt den Spieler zum taktischen Einsatz, da Schüsse eine knappe Ressource sind. | **MVP** |
| **Schlüssel** | Zwingend erforderlich, um die Level-Tür (den Ausgang) aufzusperren. | **MVP** |
| **Bombe** | Zeigt einen roten Gefahrenradius und einen Countdown an. Explodiert nach Ablauf der Zeit und tötet den Spieler im Radius. | **Post-MVP** |

### 3.4 Sieg- und Niederlagebedingungen

#### Die Siegbedingung (Level Clear)
Der Ausgang befindet sich am Ende der Map. Er öffnet sich **nur**, wenn zwei Bedingungen gleichzeitig erfüllt sind:
1. Der Spieler hat den **Schlüssel** aus einer Kiste eingesammelt.
2. Der Spieler hat **alle Monster** im Level erfolgreich getötet.

> **Designer-Notiz:** Gemäss den initialen Anforderungen müssen alle Monster getötet werden. Für die finale mobile Version sollte beim Playtesting evaluiert werden, ob dies zu Frust führt (z. B. wenn ein Gegner am Level-Anfang übersehen wurde). Eine Anpassung auf "Schlüssel + reines Überleben" bleibt als Fallback-Option offen.

#### Die Niederlagebedingungen (Game Over)
Der Spieler hat im MVP kein klassisches Lebenspunktesystem (HP), sondern stirbt durch "One-Hit-Kills" auf drei Arten:
* **Feindkontakt:** Direkte Berührung mit einem Monster.
* **Absturz:** Der Spieler fällt in die Tiefe (untere Grenze der Map / Killzone).
* **Explosion:** Aufenthalt im roten Umkreis einer Bombe nach Ablauf des Countdowns *(Feature für spätere Versionen)*.

---

## 4. Level Design & Umgebung
Die Spielwelt basiert auf einer reinen 2D-Seitenansicht (Side-Scroller) und wird über Godots kachelbasiertes System umgesetzt:

* **Blöcke & Plattformen:** Bilden das Grundgerüst des Levels. Der Spieler muss präzise Sprünge von Block zu Block timen.
* **Vertikalität & Abgründe:** Tiefe Lücken zwischen den Blöcken erzeugen mechanische Spannung und bestrafen ungenaue Eingaben sofort mit dem virtuellen Tod.
* **Pacing:** Die Levels führen den Spieler schrittweise ein. Zuerst einfache Sprünge, gefolgt vom Einsammeln der Kisten, bis hin zu kombinierten Geschicklichkeitspassagen mit platzierten Monstern.

---

## 5. Benutzeroberfläche (HUD)
Das Heads-Up Display (HUD) ist minimalistisch gestaltet, um den Fokus auf kleineren Smartphone-Displays nicht zu stören:

1. **Munitions-Anzeige:** Ein sichtbarer Zähler (z. B. `Munition: 5 / 10`) in der oberen linken Ecke.
2. **Schlüssel-Indikator:** Ein Icon, das ausgegraut ist und farbig aufleuchtet, sobald der Schlüssel im Besitz des Spielers ist.
3. **Monster-Tracker:** Ein kompakter Zähler (z. B. `Gegner: 3 / 5`), damit der Spieler jederzeit weiss, wie viele Monster noch besiegt werden müssen.

---

## 6. Technische Anforderungen & Architektur (Godot 4)
Um das knappe Entwicklungszeitfenster optimal zu nutzen, wird das Projekt wie folgt strukturiert:

* **Player-Knoten:** Umsetzung mittels `CharacterBody2D`. Dieser Knotentyp in Godot 4 eignet sich hervorragend für präzise Platformer-Physik (`move_and_slide()`).
* **Level-Struktur:** Nutzung von `TileMap` (bzw. `TileMapLayer` in neueren Godot 4-Versionen) für schnelles und modulares Prototyping der Blöcke.
* **Touch-Input:** Verwendung von `TouchScreenButton`-Nodes. Diese lassen sich im Inspektor direkt mit den Aktionen der *Input Map* verknüpfen, sodass Desktop-Tastaturtests und Mobile-Touchtests denselben Code nutzen.
* **Assets:** Verwendung von kostenlosen, konsistenten 2D-Assets (z. B. von *Kenney.nl*), um Programmieraufwand zu priorisieren und Grafik-Design-Zeit einzusparen.
