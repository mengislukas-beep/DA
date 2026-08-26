#import "../../../../style.typ": *



= Ex01

#set enum(numbering:"*")
+ Allgemeines (Laden, Pfad)
+ ```python data = np.loadtxt(file, skiprows=1, delimiter="|", comments="#", unpack=True) ```
+ ```python np.savetxt('DataOut.txt', (x, y, z), delimiter=',') ```
+ einfacher Plot mit "scatter"
+ Formatting
+ Dateien wieder speichern

= Ex02
#set enum(numbering:"*")
+ ```python import numpy as np
import matplotlib.pyplot as plt ```
+ einfacher Plot mit "plot"
+ Histogramm
+ Funktion zur Bestimmung der Frequenz "get_frequency"
= Ex03

#set enum(numbering:"*")
+ einfache Funktionen
+ Mittelwert $mu$ und Standardabweichung $sigma$ (ddof=0 $=> 1/N$, ddof=1 $=> 1/(N-1)$)
+ Plot mit linspace und nochmals ein Plot mit Balken
+ die Aufgabe mit den Coins
+ ```python n = 10        # Anzahl Versuche
p = 0.3       # Erfolgswahrscheinlichkeit
N = 10000     # Anzahl Stichproben

x = np.random.binomial(n, p, N) 
# x = random.choice([0,1,2], p=[0.3,0.2,0.5],size=n)
plt.hist(x, bins=np.arange(-0.5, n+1.5, 1), density=True) ```
+ $mu = n p$ und $sigma^2 = n p (1-p)$ theoretische Werte oder einfach den Versuch tausendmal ausführen und dann den Mittelwert nehmen

= Ex04

#set enum(numbering:"*")
+ Plotten mit logspace
+ Unsicherheit des Mittelwertes
  $
    sigma_overline(x) = sigma/sqrt(N)
  $
+ Gaußsche Fehlerfortpflanzung
+ Kovarianz/Korrelationskoeffizienten/Autokovarianz
+ $
    r = "cov"(x,y)/(sigma_x sigma_y) quadd  -1 <= r <= 1
  $
  -1 perfekte negative Korrelation 0 keine Korrelation 1 perfekte korrelation
+ $
sigma_f^2 =
sum_i
(
frac(partial f, partial x_i)
)^2
sigma_i^2
+
2
sum_(i < j)
frac(partial f, partial x_i)
frac(partial f, partial x_j)
"Cov"(x_i, x_j)
$
= Ex05
#set enum(numbering: "*")
+ Autokovarianz als Funktion der Zeit
+ Weißes Rauschen: keine Korrelation

= Ex06

#set enum(numbering: "*")
+ Fouriertransformation
+ Nyquist-Frequenz
+ ```python
np.argmax()
idx = np.argsort(x)[-3:]
from scipy.signal import find_peaks
```
+ Peaks finden
  ```python
  from scipy.signal import find_peaks

  peaks, _ = find_peaks(y)

  // Drei höchste Peaks auswählen
  idx = peaks[np.argsort(y[peaks])[-3:]][::-1]

  print(idx)      // Indizes der drei höchsten Peaks
  print(y[idx])   // Peak-Höhen
  ```

= Ex07

#set enum(numbering: "*")
+ Moving Average
+ Glättet das Signal und entfernt schnelles Rauschen.
+ Filtern im Frequenzraum
+ Signal Reconstruction (Signalrekonstruktion)
+ Hochpass und Tiefpass
  - Tiefpass: Lässt tiefe Frequenzen durch und unterdrückt hohe Frequenzen.
    - Verwendung: Wenn hochfrequentes Rauschen entfernt oder das Signal geglättet werden soll.
    - Beispiele: Sensorrauschen entfernen, Messdaten glätten.
  - Hochpass: Lässt hohe Frequenzen durch und unterdrückt tiefe Frequenzen.
    - Verwendung: Wenn langsame Trends oder Offsets entfernt und schnelle Änderungen hervorgehoben werden sollen.
    - Beispiele: Kanten in Bildern erkennen, plötzliche Signaländerungen analysieren.
+ ein guter Plot der fft macht "noisy_pulse"

= Ex08

#set enum(numbering: "*")

+ Wahrscheinlichkeitsmassenfunktion
+ Mode / Median / Mediansort / Mean
+ FWHM:
  $
  F W H M = 2 sigma sqrt(2 log 2)
  $
+ Momente
  + Achtung: Es gibt einen Unterschied zwischen dem Moment und dem zentralen Moment.
  ```python
  import numpy as np

  def central_moment(x, k):
      x = np.asarray(x)
      mu = np.mean(x)
      return np.mean((x - mu)**k)

  def moment(data, n):
      return np.sum(data**n) / len(data)
  ```
+ Das dritte zentrale Moment ist für eine symmetrische Verteilung gleich 0 und für eine asymmetrische Verteilung ungleich 0.

= Ex09

#set enum(numbering: "*")

+ Gaußsche Normalverteilung
  $
  f(x) = 1 / (sqrt(2 pi sigma^2))
  e^(-1/2 (x - mu)^2 / sigma^2)
  $
+ Zentraler Grenzwertsatz
  - Beschreibt, dass sich die Summe bzw. der Mittelwert vieler unabhängiger und identisch verteilter Zufallsvariablen einer Normalverteilung annähert.
  - Gilt unabhängig von der ursprünglichen Verteilung der Daten (bei genügend großer Stichprobe und endlicher Varianz).
  - Wichtig: Die Daten müssen unabhängig und identisch verteilt (i.i.d.) sein.
  - Die Art der Stichprobenziehung ist entscheidend, damit der Satz anwendbar ist.

= Ex10

#set enum(numbering: "*")

+ Lineares Fitten
  ```python
  a, cov = np.polyfit(
      x,          # x-Daten
      y,          # y-Daten
      deg=1,      # Grad des Polynoms (1 = Gerade)
      w=None,     # Gewichte (z.B. 1/sigma)
      cov=True    # Kovarianzmatrix zurückgeben
  )
  ```
  

+ Chi-Quadrat-Funktion
  $
  chi^2 = sum_i ((y_i - f(x_i))/sigma_i)^2
  $

  - Misst die Abweichung zwischen Messdaten und Modell.
  - $chi_"red"^2 approx 1$: guter Fit.
  - $chi_"red"^2 >> 1$: schlechter Fit oder Unsicherheiten zu klein.
  - $chi_"red"^2 << 1$: Unsicherheiten zu groß oder Modell passt "zu gut".

  Reduziertes Chi-Quadrat (wenn es sehr viel Datenpunkte hat):
  $
  chi_"red"^2 = chi^2 / (N - "len"(a))
  $

  - $N$: Anzahl Messpunkte.
  - $a$: Anzahl der Fitparameter.

+ `pcolormesh`
  - Erstellt eine 2D-Farbkarte für Matrixdaten.
  - Geeignet für Heatmaps und Intensitätsverteilungen.

= Ex11

#set enum(numbering: "*")
+ Gradient and descent
+ Nichtlinearer Fit (`scipy.optimize.curve_fit`)
  ```python
  def f(x, a, b,c):
    return a * b * c

  from scipy.optimize import curve_fit
  popt, pcov = curve_fit(
      f,              # Modellfunktion
      xdata,          # x-Daten
      ydata,          # y-Daten
      p0=None,        # Startwerte der Parameter
      sigma=None,     # Messunsicherheiten
      absolute_sigma=False/True,
      )
  a, b, c = popt
  ```
  In popt wären dann alle Fitparameter 

= Ex12

#set enum(numbering: "*")
+ Datenverarbeitung mit pandas
+ Regressions 
  + linear
  + polynomial
  + Ridge_regr
  
+ beste Hyperparameter finden 
  ```python from sklearn.model_selection import GridSearchCV
```
= Ex13

#set enum(numbering: "*")

+ Logistische Regression
+ MLP Classifier
+ `accuracy_score`
+ Propagation durch ein neuronales Netz
+ `pickle`

= Ex14

#set enum(numbering: "*")

+ Listen bearbeiten / Bereinigung
+ `SimpleImputer`
+ One-Hot-Kodierung (wenn Daten Kategorisch sind )
+ Mean-Kodierung
+ KNN und Decision Tree
+ Wann muss man einen Scaler verwenden?
  - Scaler verwenden bei Verfahren, die Abstände oder Gradienten verwenden:
    - KNN
    - Logistische Regression
    - MLP / Neuronale Netze
    - SVM
  - Kein Scaler nötig bei:
    - Decision Tree
    - Random Forest
+ Beispiel code
```python tree = DecisionTreeClassifier(random_state=42)

X = df.drop(columns=['diagnosis'])
y = df['diagnosis']

# Daten Aufteilen in Trainings- und Testdaten
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Daten skalieren

scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train) # falls nötig
X_test_scaled = scaler.transform(X_test)

tree.fit(X_train, y_train) #falls scaler angewendet natürlich ..._scaled

y_pred_train = tree.predict(X_train) 
y_pred_test = tree.predict(X_test)

accuracy_train = accuracy_score(y_train, y_pred_train)
accuracy_test = accuracy_score(y_test, y_pred_test)

print("Trainingsgenauigkeit:", accuracy_train)
print("Testgenauigkeit:", accuracy_test)```

= Andere Sachen
#set enum(numbering: "*")
+ Messung = $underbrace(x,"tatsächlich") dot underbrace(G,"Gain")$
+ $sigma^2 = "PSD" dot underbrace(Delta T, "intervall")$
+ #table(
  columns: 3,
  [], [Erwartungswert],[std],
  [$"Bin"(N,p)$],[$N dot p$],[$sqrt(N p(1-p))$],
  [$"poisson"(lambda)$],[$lambda$],[$sqrt(lambda)$],
  [$"Normal"(mu, sigma^2)$],[$mu$],[$sigma$],
)
+ Poisson $lambda := "Erwartungswert"$ & $k := "Eregnisse"$ Werte von 0 bis 1 (Wahrscheinlichkeit).
  $
    p(k,lambda) = (lambda^k e^(-lambda))/(k!)
  $
+ Wie man die Matrixen verarbeitet
  + Relu: $f(x)= max(0,x)$
  + tanh: $f(x)= tanh(x)$
  + sigmoid $f(x) = 1/(1+e^(-x))$
  + Pooling
    + Standart
      $
        mat(a_1,a_2;a_3,a_4) -> mat(max(a_(1 1), a_(1,2),a_(1 3)a_( 1 4)),dots;dots,dots)
      $
    + average pooling
    + min pooling
    + l2 pooling $:= sqrt(sum_i x_i^2)$
