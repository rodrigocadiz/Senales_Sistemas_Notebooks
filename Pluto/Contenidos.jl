### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ ee16448d-6d3d-47c2-9095-e0574cf3a255
md""" 

# Procesamiento avanzado de señales

"""

# ╔═╡ ed6f3382-98b7-4c81-9f9f-2850a91dfa81
md"""
!!! header ""
    Este notebook es parte de una colección de apuntes para el curso **IEE3702 Procesamiento Avanzado de Señales**, [Departamento de Ingeniería Eléctrica](https://www.ing.uc.cl/electrica/), [Pontificia Universidad Católica de Chile](https://www.uc.cl). **Profesor: Rodrigo F. Cádiz** - Consultas y comentarios: [rcadiz@ing.puc.cl](mailto://rcadiz@ing.puc.cl)
"""

# ╔═╡ bd07afb2-f573-11eb-042e-db29e8f06ba8
md""" 
## A. Sistemas y señales continuas en $\mathbb{R}^2$

A.1. [Sistemas 2D](PAS-A-Sistemas_2D.jl.html)

A.2. [Señales 2D](PAS-A-Senales_2D.jl.html)

A.3. [Impulso 2D](PAS-A-Impulso_2D.jl.html)

A.4. [Convolución 2D](PAS-A-Convolucion_2D.jl.html)

A.5. [Transformada de Fourier 2D](PAS-A-Fourier_2D.jl.html)

A.6. [Pares de Fourier 2D](PAS-A-Pares_Fourier_2D.jl.html)

A.7. [Propiedades de la Transformada de Fourier 2D](PAS-A-Propiedades_Fourier_2D.jl.html)

A.8. [Otras Transformadas 2D continuas](PAS-A-Otras_Transformadas_2D.jl.html)

A.9. [Extensión a $\mathbb{R}^n$](PAS-A-Extension_Rn.jl.html)


## B. Sistemas y señales discretas en $\mathbb{Z}^2$

B.1. [Sistemas 2D](PAS-B-Sistemas_2D.jl.html)

B.2. [Muestreo 2D](PAS-B-Muestreo_2D.jl.html)

B.3. [Señales 2D](PAS-B-Senales_2D.jl.html)

B.4. [Convolución 2D](PAS-B-Convolucion_2D.jl.html)

B.5. [2D-DFT](PAS-B-2D_DFT.jl.html)

B.6. [Propiedades de la 2D-DFT](PAS-B-Propiedades_2D_DFT.jl.html)

B.7. [Otras Transformadas 2D discretas](PAS-B-Otras_Transformadas_2D.jl.html)

B.8. [Extensión a $\mathbb{Z}^n$](PAS-B-Extension_Zn.jl.html)


## C. Señales y procesos estocásticos

C.1. [Variables aleatorias](PAS-C-Variables_aleatorias.jl.html)

C.2. [Procesos estocásticos](PAS-C-Procesos_estocasticos.jl.html)

C.3. [Autocorrelación](PAS-C-Autocorrelacion.jl.html)

C.4. [Propiedades de los procesos estocásticos](PAS-C-Propiedades_procesos_estocasticos.jl.html)

C.5. [Densidad espectral de potencia](PAS-C-Densidad_espectral_de_potencia.jl.html)

C.6. [Sistemas lineales con entradas aleatorias estacionales](PAS-C-Sistemas_lineales.jl.html)


## D. Modelos lineales de señal

D.1. Modelos lineales no paramétricos

D.2. Modelos de polos (all-pole)

D.3. Modelos de ceros (all-zero)

D.4. Modelos de polos y ceros (pole-zeros)


## E. Estimación no paramétrica del espectro

E.1. Periodograma

E.2. Periodograma modificado

E.3. Método de Blackman-Tukey

E.4. Método de Welch-Bartlett


## F. Estimación paramétrica del espectro

F.1. Estimación de modelos de polos

F.2. Estimación de modelos de polos y ceros

F.3. Métodos de varianza mínima

F.4. Modelos harmónicos


## G. Filtros lineales óptimos

G.1. Estimación óptima de señales

G.2. Estimación mediante error cuadrático medio

G.3. Filtro Wiener

G.4. Predicción lineal

G.5. Filtros inversos y deconvolución

G.6. Matched filters y auto filtros

G.7. Filtro Kalman


## H. Filtros adaptativos

H.1. Principios de los filtros adaptativos

H.2. Método de la máximo pendiente

H.3. Método de los mínimos cuadrados


## I. Aplicaciones

I.1. Tomografía

I.2. Cancelación de ruido

I.3. Cancelación de eco

I.4. Restauración de imágenes mediante el filtro Wiener

I.5. Predicción del tiempo con filtros Kalman




"""

# ╔═╡ 1301edb1-eaa3-4074-9606-cc958ece50b4
md"""

***

"""

# ╔═╡ f4cfe9cc-3fb4-47b5-a800-fbcf09d13400
md"""
!!! footer ""
	Estos apuntes están licenciados bajo la licencia [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/). **Como citar: Rodrigo F. Cádiz, Procesamiento Avanzado de Señales, 2021.**
"""

# ╔═╡ Cell order:
# ╟─ee16448d-6d3d-47c2-9095-e0574cf3a255
# ╟─ed6f3382-98b7-4c81-9f9f-2850a91dfa81
# ╟─bd07afb2-f573-11eb-042e-db29e8f06ba8
# ╟─1301edb1-eaa3-4074-9606-cc958ece50b4
# ╟─f4cfe9cc-3fb4-47b5-a800-fbcf09d13400
