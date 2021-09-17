### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 0a93661f-9c7f-42c7-987c-8087f6d59f3e
using PlutoUI

# ╔═╡ 8f4e95b7-6c7e-4ecc-a1fd-acc033493344
md"""
!!! header ""
    Este notebook es parte de una colección de apuntes para el curso **IEE3702 Procesamiento Avanzado de Señales**, [Departamento de Ingeniería Eléctrica](https://www.ing.uc.cl/electrica/), [Pontificia Universidad Católica de Chile](https://www.uc.cl). **Profesor: Rodrigo F. Cádiz** - Consultas y comentarios: [rcadiz@ing.puc.cl](mailto://rcadiz@ing.puc.cl)
"""

# ╔═╡ 347106f9-63cb-49f9-9be1-78eb2a72a1ad
md"""
[[Volver a la tabla de contenidos](Contenidos.jl.html)]
"""

# ╔═╡ 0040c4e3-eeab-4a5f-bcf4-c3caa536a5ed
md"""
# Extensión a $\mathbb{R}^n$

Tal como es posible definir y operar con señales y transformadas en $\mathbb{R}^2$, de la misma forma pueden estos conceptos ser extendidos a un espacio de $n$ dimensiones, es decir $\mathbb{R}^n$.
"""

# ╔═╡ ede9adbd-8c69-4ee1-b51e-b6244bc50f5b
md"""
## Señales en $\mathbb{R}^n$

Una señal $f \in \mathbb{R}^n$ se define como una función de la forma

!!! note ""
	$$f\left(x_{1}, \ldots, x_{n}\right)$$

donde $f:\mathbb{R}^n \rightarrow \mathbb{R}$ o bien $f:\mathbb{R}^n \rightarrow \mathbb{C}$.

Si definimos la variable $n$-dimensional $\mathbf{x} = (x_{1}, x_{2}, \ldots, x_{n}) \in \mathbb{R}^n$, entonces una señal se puede anotar en forma compacta como

!!! note ""
	$$f(\mathbf{x})$$

"""

# ╔═╡ 9c9b0072-540c-4cd0-a396-5f499049bfc1
md"""
## Sistemas en $\mathbb{R}^n$

Podemos concebir sistemas que operan sobre señales en $\mathbb{R}^n$. En este caso los denotamos en forma vectorial como

!!! note ""
	$$g(\mathbf{x}) = \mathcal{S}\{f\}(\mathbf{x})$$

o bien

!!! note ""
	$$f(\mathbf{x}) \xrightarrow{\mathcal{S}} g(\mathbf{x})$$

donde $\mathcal{S}$ denota un sistema en particular.

"""

# ╔═╡ 18ba90d5-3f82-41f2-b32a-475585f729d8
md"""
## Producto punto

Definimos el producto punto, interno o escalar entre dos vectores en $\mathbb{R}^n$ como

!!! note 
	$$\mathbf{x} \cdot \mathbf{\xi}=x_{1} \xi_{1}+x_{2} \xi_{2}+\cdots+x_{n} \xi_{n}$$

"""

# ╔═╡ fb5ac048-0e80-4fd8-b673-ca043596ca38
md"""
## Impulso en $\mathbb{R}^n$

La distribución impulso en $\mathbb{R}^n$ puede definirse en forma análoga a los casos uni o bi-dimensionales. Es decir,

!!! note ""
	$$\langle\delta, \varphi\rangle=\varphi(0, \ldots, 0)$$

o en notación vectorial

!!! note ""
	$$\langle\delta, \varphi\rangle=\varphi(\mathbf{0})$$



donde $\varphi\left(x_{1},, \ldots, x_{n}\right)$ es una función de Schwartz

Relajando la notación, estas nociones típicamente se expresan como 

> $$\int_{\mathbb{R}^{n}} \varphi(\mathbf{x}) \delta(\mathbf{x}) d \mathbf{x}=\varphi(\mathbf{0})$$

"""

# ╔═╡ 57198d23-2ff3-43ca-b34f-0313aabb7a22
md"""
### Propiedades del impulso

Las propiedades conocidas el impulso para una o dos dimensiones, se mantienen en el caso $n$-dimensional. Por ejemplo, la propiedad del muestreo 

!!! note ""
	$$f(\mathbf{x}) \delta=f(\mathbf{0}) \delta$$

o de la convolución

!!! note ""
	$$(f * \delta)(\mathbf{x})=f(\mathbf{x})$$
"""

# ╔═╡ 2f9a5790-eddf-4275-a9c8-5eb37e6dd193
md"""
### Impulso desplazado

La distribución $\delta$ desplazada puede definirse mediante el operador de desplazamiento $\tau$:

!!! note ""
	$$\delta_{\mathbf{b}}=\tau_{\mathbf{b}} \delta$$ 

o en una notación menos estricta

!!! note ""
	$$\delta(\mathbf{x}-\mathbf{b})=\delta\left(x_{1}-b_{1}, x_{2}-b_{2},\ldots, x_{n}-b_{n}\right)$$

Esta distribución tiene las propiedades

> $$f(\mathbf{x}) \delta_{\mathbf{b}}=f(\mathbf{b})\delta_{\mathbf{b}}$$

y también

> $$f * \delta_{\mathbf{b}}=f * \tau_{\mathbf{b}} \delta=\tau_{\mathbf{b}} f=f(\mathbf{x}-\mathbf{b})$$

"""

# ╔═╡ 665a3ba9-ac1e-471d-ad63-f636b510fb50
md"""
### Separabilidad

En muchos casos, es de utilidad separar el impulso mediante el producto tensor. Entonces, podemos escribir

!!! note ""
	$$\delta\left(x_{1}, x_{2}, \ldots, x_{n}\right)=\delta_{1}\left(x_{1}\right) \otimes \delta_{2}\left(x_{2}\right) \otimes \cdots \otimes \delta_{n}\left(x_{n}\right)$$


!!! warning ""
	Es importante tener en mente que en general las distribuciones no pueden ser multiplicadas, sin embargo en el caso de la distribución $\delta$, esta idea cobra sentido, dado que el efecto de cada impulso es posible de entener como una composición del efecto de aplicar un impulso en cada una de las $n$ dimensiones.
"""

# ╔═╡ 47d3b4b4-de2c-4371-91e0-216d6ab7a5ea
md"""
## Transformada de Fourier en $\mathbb{R}^n$

Podemos concebir la Transformada continua de Fourier en $n$ dimensiones de la siguiente forma:

> $$\mathcal{F} f\left(\xi_{1}, \xi_{2}, \ldots, \xi_{n}\right)=\int_{\mathbb{R}^{n}} e^{-2 \pi i\left(x_{1} \xi_{1}+\cdots+x_{n} \xi_{n}\right)} f\left(x_{1}, \ldots, x_{n}\right) d x_{1} \ldots d x_{n}$$

"""

# ╔═╡ 4fe6c8e5-a59f-43df-bb86-0089a803f2ed
md"""
donde el vector

> $$\mathbf{\xi}=\left(\xi_{1}, \xi_{2}, \ldots, \xi_{n}\right)$$

puede interpretarse como las variables de frecuencia duales de las variables  $\mathbf{x}$. La dimensión de $\xi_{i}$ es el recíproco de la dimensión de $x_{i}$

En forma más compacta, la Transformada de Fourier de una señal en $\mathbb{R}^n$ de $f(\mathbf{x})$ es la función $\mathcal{F}\{f\}(\xi)$ definida por 

!!! note "Definición" 
	$$\mathcal{F}\{f\}(\mathbf{\xi})=\int_{\mathbb{R}^{n}} e^{-2 \pi i \mathbf{x} \cdot \xi} f(\mathbf{x}) d \mathbf{x}$$

La Transformada de Fourier inversa está dada por:

!!! note "Definición"
	$$\mathcal{F}^{-1}\{f\}(\mathbf{x})=\int_{\mathbb{R}^{n}} e^{2 \pi i \mathbf{x} \cdot \mathbf{\xi}} \mathcal{F}\{f\}(\xi) d \xi$$

"""

# ╔═╡ 94fd90c8-73fc-47a9-a659-1eeb252847a8
md"""
### Separabilidad

En muchos casos es posible escribir una función de $n$ variables $f\left(x_{1}, \ldots, x_{n}\right)$ como un producto de $n$ funciones de una sola variable:

> $$f\left(x_{1}, \ldots, x_{n}\right)=f_{1}\left(x_{1}\right) f_{2}\left(x_{2}\right) \cdots f_{n}\left(x_{n}\right)$$

Esta idea es central al método de separación de variables en la solución de ecuaciones diferenciales parciales.

Cuando una función es separable, su Transformada de Fourier se puede calcular como el producto de las Transformadas de Fourier uni-dimensionales sobre cada variable. En general, si 

> $f\left(x_{1}, x_{2}, \ldots, x_{n}\right)=f_{1}\left(x_{1}\right) f_{2}\left(x_{2}\right) \cdots f_{n}\left(x_{n}\right)$

entonces

> $$\mathcal{F}\{f\}\left(\xi_{1}, \xi_{2}, \ldots, \xi_{n}\right)=\mathcal{F} \{f_{1}\}\left(\xi_{1}\right) \mathcal{F}\{f_{2}\}\left(\xi_{2}\right) \cdots \mathcal{F}\{f_{n}\}\left(\xi_{n}\right)$$
"""

# ╔═╡ 1377eaf7-77e2-495d-ad8b-355446a3451a
md"""

 ### Escalamiento y desplazamiento. 

Utilizando los operadores de escalamiento $\sigma_{A}$ y de desplazamiento $\tau_b$, entonces se cumple que:

!!! note ""
	$$\begin{align}\mathcal{F}\{\left(\sigma_{A}\left(\tau_{\underline{b}} f\right)\right)\}(\xi)=\frac{1}{|\operatorname{det} A|} \mathcal{F}\{\left(\tau_{\underline{b}} f\right)\}\left(A^{-\top} \xi\right) \\ =\frac{1}{|\operatorname{det} A|} \exp \left(-2 \pi i A^{-\mathrm{T}} \underline{\xi} \cdot \underline{b}\right) \mathcal{F} \{f\}\left(A^{-\top} \xi\right)\end{align}$$

"""

# ╔═╡ 884020d4-42e9-459c-aa23-3f819a672be5
md"""
### Derivadas

Al considerar señales de $n$ dimensiones, la operación derivar implica muchas derivadas parciales. Sin embargo, el criterio general se mantiene: la Transformada de Fourier intercambia derivación por multiplicación.

Por lo tanto:

!!! note "" 
	$$\begin{aligned}\frac{\partial}{\partial \xi_{k}} \mathcal{F}\{f\}(\xi) &=\mathcal{F}\{-2 \pi i x_{k} f\}(\mathbf{x}) \\ \mathcal{F}\{\frac{\partial}{\partial x_{k}} f\}(\xi) &=2 \pi i \xi_{k} \mathcal{F}\{f\}(\mathbf{\xi})\end{aligned}$$
"""

# ╔═╡ 75cd6b84-cba2-4e06-89c6-d4147bcae0ea
md"""
### Convolución


Para dos funciones $f, g \in \mathbb{R}^{n}$ se tiene que

!!! note ""
	$$(f * g)(\mathbf{x})=\int_{\mathbb{R}^{n}} f(\mathbf{x}-\mathbf{a}) g(\mathbf{a}) d \mathbf{a}$$

En forma adicional, la propiedades de la convolución y multplicación de la Transformada de Fourier, se mantienen:

!!! note ""
	$$\mathcal{F}\{(f * g)\}(\mathbf{\xi})=\mathcal{F}\{f\}(\mathbf{\xi}) \mathcal{F}\{g\}(\xi) \quad \text { y } \quad \mathcal{F}\{(f g)\}(\xi)=(\mathcal{F}\{f\} * \mathcal{F}\{g\})(\mathbf{\xi})$$

"""

# ╔═╡ 2404fae6-9366-4893-bac6-a5c9a730fca8
md"""
### Parseval-Plancherel

En $n$ dimensiones, las identidades de Parseval-Plancherel se mantienen, es decir

!!! note ""
	$$\begin{aligned} \int_{\mathbb{R}^{n}} f(\mathbf{x}) g^{\ast}(\mathbf{x}) d \mathbf{x} &=\int_{\mathbb{R}^{n}} \mathcal{F}\{f\}(\mathbf{\xi}) \mathcal{F}^{\ast} \{g\}(\xi) d \xi \\ \int_{\mathbb{R}^{n}}|f(\mathbf{x})|^{2} d \mathbf{x} &=\int_{\mathbb{R}^{n}}|\mathcal{F}\{f\}(\mathbf{\xi})|^{2} d \xi\end{aligned}$$

"""

# ╔═╡ cc974ab5-105d-4618-927b-4c6badd088f3
md"""
***
[[Volver a la tabla de contenidos](./Contenidos.jl.html)]
"""

# ╔═╡ 877dce18-da35-4dc7-96e7-cedc55414c69
md"""
!!! footer ""
	Estos apuntes están licenciados bajo la licencia [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/). **Como citar: Rodrigo F. Cádiz, Procesamiento Avanzado de Señales, 2021.**
"""

# ╔═╡ b5a5849c-77a9-4ade-ad30-f29eb726d0b5
PlutoUI.TableOfContents(title="Indice", indent=true, depth=4, aside=true)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.9"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "438d35d2d95ae2c5e8780b330592b6de8494e779"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.3"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╟─8f4e95b7-6c7e-4ecc-a1fd-acc033493344
# ╟─347106f9-63cb-49f9-9be1-78eb2a72a1ad
# ╟─0040c4e3-eeab-4a5f-bcf4-c3caa536a5ed
# ╟─ede9adbd-8c69-4ee1-b51e-b6244bc50f5b
# ╟─9c9b0072-540c-4cd0-a396-5f499049bfc1
# ╟─18ba90d5-3f82-41f2-b32a-475585f729d8
# ╟─fb5ac048-0e80-4fd8-b673-ca043596ca38
# ╟─57198d23-2ff3-43ca-b34f-0313aabb7a22
# ╟─2f9a5790-eddf-4275-a9c8-5eb37e6dd193
# ╟─665a3ba9-ac1e-471d-ad63-f636b510fb50
# ╟─47d3b4b4-de2c-4371-91e0-216d6ab7a5ea
# ╟─4fe6c8e5-a59f-43df-bb86-0089a803f2ed
# ╟─94fd90c8-73fc-47a9-a659-1eeb252847a8
# ╟─1377eaf7-77e2-495d-ad8b-355446a3451a
# ╟─884020d4-42e9-459c-aa23-3f819a672be5
# ╟─75cd6b84-cba2-4e06-89c6-d4147bcae0ea
# ╟─2404fae6-9366-4893-bac6-a5c9a730fca8
# ╟─cc974ab5-105d-4618-927b-4c6badd088f3
# ╟─877dce18-da35-4dc7-96e7-cedc55414c69
# ╟─0a93661f-9c7f-42c7-987c-8087f6d59f3e
# ╟─b5a5849c-77a9-4ade-ad30-f29eb726d0b5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
