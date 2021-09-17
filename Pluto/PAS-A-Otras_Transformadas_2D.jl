### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 13bd7a57-aa41-45f8-81b4-caf1694463af
using PlutoUI, ImageIO, ImageFiltering, TestImages

# ╔═╡ 623b9a5d-4228-4e59-94fe-6cb47ebcda4c
md"""
!!! header ""
    Este notebook es parte de una colección de apuntes para el curso **IEE3702 Procesamiento Avanzado de Señales**, [Departamento de Ingeniería Eléctrica](https://www.ing.uc.cl/electrica/), [Pontificia Universidad Católica de Chile](https://www.uc.cl). **Profesor: Rodrigo F. Cádiz** - Consultas y comentarios: [rcadiz@ing.puc.cl](mailto://rcadiz@ing.puc.cl)
"""

# ╔═╡ ca584849-8be4-4580-aa77-f268dafc850f
md"""
[[Volver a la tabla de contenidos](Contenidos.jl.html)]
"""

# ╔═╡ 0040c4e3-eeab-4a5f-bcf4-c3caa536a5ed
md"""
# Otras transformadas continuas en $\mathbb{R}^2$
"""

# ╔═╡ 6e0ff96b-528c-4c09-87fb-0d6c9d71439a
md"""
## Transformada Wavelet

La Transformada Wavelet bi-dimensional es una herramienta muy útil para examinar sets de datos no estacionarios en un plano o para eliminación de ruido en imágenes. En comparación con la Transformada de Fourier, la Transformada Wavelet proporciona información espectral localizada de los datos. 

El punto de partida para la Transformada Wavelet es comenzar con una función base, conocida como la **wavelet madre**. A partir de una wavelet madre  $\psi \in$ $L^{2}(\mathbb{R}^2)$, se genera una familia de wavelets transladadas, dilatadas y rotadas $\psi_{a,\mathbf{b},\theta}$.

### Condición de admisibilidad
Sean $\mathbf{x}=(x_1,x_2), \mathbf{u}=(u_1,u_2) \in \mathbb{R}^2$. La wavelet madre debe cumplir con la condición de admisibilidad:

> $$C_{\psi}=\int_{\mathbb{R}^2} |\Psi(\mathbf{u})|^{2} \frac{\mathrm{d} \mathbf{u}}{|\mathbf{u}|}<\infty$$

donde 

> $$\Psi(\mathbf{u})=\int_{\mathbb{R}^2} \psi(\mathbf{x}) \mathrm{e}^{-i 2 \pi \mathbf{u}\mathbf{x}} \mathrm{~d} \mathrm{x}$$

denota la Transformada de Fourier bi-dimensional de $\psi$. Si $\psi$ es integrable, esto es, $\psi \in$ $L^{1}(\mathbb{R^2})$, esto implica que $\psi$ tiene media cero: 

> $$\int_{\mathbb{R}^2} \psi(\mathbf{x}) \mathrm{d} \mathbf{x}=0 \quad \text { o } \quad \Psi(0)=0$$

Sea $\mathbf{x}=(x_1,x_2) \in \mathbb{R}^2$. Se define la Transformada Wavelet $\mathcal{W}$ de la función $f \in \mathrm{L}^2(\mathbb{R}^2)$ como

!!! note "Definición"
	$$\mathcal{W}\{f\}(a,\mathbf{b},\theta) = F_\mathcal{W}(a,\mathbf{b},\theta) = \int_{\mathbb{R}^2} f(\mathbf{x}) \psi_{a,\mathbf{b},\theta}^{*} d\mathbf{x}$$


donde las bases de la transformada, denominadas Wavelets y denotadas por $\psi$, son tales que:

!!! note "Definición"
	$$\psi_{a,\mathbf{b},\theta}(\mathbf{x}) = \frac{1}{a}\psi\{\mathbf{R}_\theta^{-1}\left(\frac{\mathbf{x}-\mathbf{b}}{a}\right)\}$$

y $a$ es un factor de escalamiento, $\mathbf{b}$ es un vector de desplazamientos, y $\mathbf{R}_{\theta}$ es una matriz de rotación de ángulo $\theta$. 


!!! warning ""
	Al considerar versiones escaladas de las bases de la transformada, es posible analizar en frecuencia la señal a distintas escalas, es decir un **análisis de multiresolución**. Esta es una importante diferencia respecto a la Transformada de Fourier, que no permite esta diferenciación.

La transformada inversa es

!!! note "Definición"
	$$f(\mathbf{x})=\frac{1}{C_{\psi}} \int_{0}^{\infty} \int_{\mathbb{R}^{2}} \int_{0}^{2 \pi} F_\mathcal{W}(a, \mathbf{b}, \theta) \psi_{a, \mathbf{b}, \theta}(\mathbf{x}) \frac{\mathrm{d} a \mathrm{~d} b \mathrm{~d} \theta}{a^{3}}$$

"""

# ╔═╡ c5d18b3d-4e9e-452e-ad2b-6ddd88e4a318
md"""
### Tipos de wavelets

Existen diversos tipos de wavelets que han sido propuestas y que han sido aplicadas en diversos campos donde el análisis espacio-frecuencial es relevante. Las más comunes son:


- [Gabor](https://en.wikipedia.org/wiki/Gabor_wavelet)
- [Morlet](https://en.wikipedia.org/wiki/Morlet_wavelet)
- [Haar](https://en.wikipedia.org/wiki/Haar_wavelet)
- [Daubechies](https://en.wikipedia.org/wiki/Daubechies_wavelet)


"""

# ╔═╡ 4460a8cc-31a7-49ba-b523-37f3ab1f15f9
md"""
## Transformada de Radon

Consideremos un corte en el plano bi-dimensional y una línea $L$ sobre ese corte. La línea se puede parametrizar mediante $x_1(s)$ y $x_2(s)$, donde $s$ es un parámetro de longitud de arco.

Para una función $f(x_1,x_2)$ la expresión

> $$\mathcal{R}_f(L) = \int_{L} f(x_1,x_2) ds$$

da un número y se denomina la Transformada de Radon de $f$ sobre la línea $L$. 

!!! warning ""
	Esta transformada representa la proyección de una función hacia una línea bi-dimensional.

"""

# ╔═╡ f144f087-a87e-4967-99b2-6f42bcd2a75a
md"""
### Teorema de la sección central

Este teorema establece que dada una función radial $f(r)$, la Transformada de Fourier de su projección hacia una línea $L$, es decir la Transformada de Fourier de la Transformada de Radon es equivalente a primero tomar la Transformada 2D de Fourier y luego tomar un plano o un corte en espacio de Fourier en esa misma línea $L$. Es decir,

Sea $f(x,y) \in \mathbb{R}^2$, $\mathcal{F}$ la Transformada de Fourier uni-dimensional, $\mathcal{F}^2$ la Transformada de Fourier bi-dimensional, $\mathcal{R}(L)$ el operador de proyección mediante la Transformada de Radon y $\mathcal{P}(L)$ el operador de corte o plano. Entonces

!!! note "Definición"
	$$\mathcal{F}\{\mathcal{R}(L)\{f\}\} = \mathcal{P}(L)\{\mathcal{F}^2\{f\}\}$$ 

Este teorema es fundamental en el campo de las imágenes médicas, en el contexto de la tomografía computarizada donde se toman proyecciones mediante rayos X de un órgano interno.

"""

# ╔═╡ c5c753fe-a2e5-4ba3-964a-0e84fb9afe38
md"""
## Transformada de Hankel

La Transformada Hankel expande una función radial 2D continua como una suma infinita de funciones de Bessel del primer orden $J_{0}(kr)$. Recordemos que estas funciones de Bessel son de la forma:

> $$J_{0}(k) = \frac{1}{2\pi}\int_{0}^{2\pi} e^{-i k \cos \theta} d\theta$$

Definimos la Transformada Hankel de una función radial $f(r)$ como

!!! note "Definición"
	$$F(k) = 2\pi \int_{0}^{\infty} f(r)J_{0}(2\pi k r) r dr$$

y la Transformada Hankel Inversa como

!!! note "Definición"
	$$f(r) = 2 \pi \int_{0}^{\infty} F(k)J_{0}(2 \pi kr) k dk$$

### Relación con la Transformada de Fourier 2D
Esta transformada aparece cuando la Transformada de Fourier 2D se escribe en coordenadas polares. Consideremos una función radial $f(r)$. Su Transformada de Fourier es

> $$F(u,v) = \int_{\mathbb{R}^2} f(r) e^{-i 2 \pi (ux + vy)} dxdy$$

con $r = \sqrt{x^2 + y^2}$. Los límites de integración podrían ser escritos de esta manera si la función $f(r)$ cubriese todo el plano $0 < r < \infty$. Sin embargo, en la práctica es de interés considerar una función constante sobre una región circular y cero en otros lugares. En este caso, podemos escribir esta expresión en coordenadas polares. Sean $(r,\theta)$ las coordenadas polares de $x,y$. 


Entonces,

> $$F(u,v) = \int_{0}^{\infty}\int_{0}^{2\pi} f(r) e^{-i 2 \pi k r \cos(\theta - \phi)}r dr d\theta$$

En esta expresión se integra de $0$ a $\infty$ en forma radial y de $0$ a $2 \pi$ en la fase. $k,\phi$ son las coordenadas polares en el plano cartesiano:

> $$k^2 = u^2 + v^2 \,\, \text{y} \,\, \tan(\phi) = v/u$$

Las bases de Fourier en estas nuevas coordenadas tienen como argumento $2 \pi k r \cos(\theta - \phi)$ porque

> $$ux + vy = \Re\{(x+iy)(u-iv)\} = \Re\{re^{i\theta}ke^{-i\phi}\} = k r \cos(\theta - \phi)$$

Reagrupando, tenemos que:

> $$F(u,v) = \int_{0}^{\infty} f(r) \left[\int_{0}^{2\pi}  e^{-i 2 \pi k r \cos(\theta - \phi)}  d\theta \right] r dr$$

donde reconocemos que $\int_{0}^{2\pi}  e^{-i 2 \pi k r \cos(\theta - \phi)}  d\theta$ es la función de Bessel de orden cero evaluada en $2 \pi k r$.

!!! warning ""
	Observamos que la Transformada Hankel es en realidad la Transformada de Fourier bi-dimensional cuando se evalúa en coordenadas polares.


"""

# ╔═╡ 1242c023-ae43-4185-bfec-a613bca1cea1
md"""
***
[[Volver a la tabla de contenidos](./Contenidos.jl.html)]
"""

# ╔═╡ 429dea13-e1c8-48e7-9c6a-7fa2d369e32c
md"""
!!! footer ""
	Estos apuntes están licenciados bajo la licencia [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/). **Como citar: Rodrigo F. Cádiz, Procesamiento Avanzado de Señales, 2021.**
"""

# ╔═╡ b5a5849c-77a9-4ade-ad30-f29eb726d0b5
PlutoUI.TableOfContents(title="Indice", indent=true, depth=4, aside=true)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
ImageFiltering = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
TestImages = "5e47fb64-e119-507b-a336-dd2b206d9990"

[compat]
ImageFiltering = "~0.6.22"
ImageIO = "~0.5.6"
PlutoUI = "~0.7.9"
TestImages = "~1.6.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "485ee0867925449198280d4af84bdb46a2a404d0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.0.1"

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[ArrayInterface]]
deps = ["IfElse", "LinearAlgebra", "Requires", "SparseArrays", "Static"]
git-tree-sha1 = "cdb00a6fb50762255021e5571cf95df3e1797a51"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "3.1.23"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "d127d5e4d86c7680b20c35d40b503c74b9a39b5e"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.4"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[CEnum]]
git-tree-sha1 = "215a9aa4a1f23fbd05b92769fdd62559488d70e9"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.1"

[[CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "bdc0937269321858ab2a4f288486cb258b9a0af7"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.3.0"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "42a9b08d3f2f951c9b283ea427d96ed9f1f30343"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.5"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "344f143fa0ec67e47917848795ab19c6a455f32c"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.32.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4437b64df1e0adccc3e5d1adbc3ac741095e4677"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.9"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "abe4ad222b26af3337262b8afb28fab8d215e9f8"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.3"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "a32185f5428d3986f47c2ab78b1f216d5e6cc96f"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.5"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[EllipsisNotation]]
deps = ["ArrayInterface"]
git-tree-sha1 = "8041575f021cba5a099a456b4163c9a08b566a02"
uuid = "da5c29d0-fa7d-589e-88eb-ea29b0a81949"
version = "1.1.0"

[[FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "70a0cfd9b1c86b0209e38fbfe6d8231fd606eeaf"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.1"

[[FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "f985af3b9f4e278b1d24434cbb546d6092fca661"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.4.3"

[[FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3676abafff7e4ff07bbd2c42b3d8201f31653dcc"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.9+8"

[[FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "256d8e6188f3f1ebfa1a5d17e072a0efafa8c5bf"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.10.1"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "2c1cf4df419938ece72de17f368a021ee162762e"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.0"

[[IfElse]]
git-tree-sha1 = "28e837ff3e7a6c3cdb252ce49fb412c8eb3caeef"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.0"

[[ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "75f7fea2b3601b58f24ee83617b528e57160cbfd"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.1"

[[ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageCore", "LinearAlgebra", "OffsetArrays", "Requires", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "79dac52336910325a5675813053b1eee3eb5dcc6"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.6.22"

[[ImageIO]]
deps = ["FileIO", "Netpbm", "PNGFiles", "TiffImages", "UUIDs"]
git-tree-sha1 = "d067570b4d4870a942b19d9ceacaea4fb39b69a1"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.5.6"

[[IndirectArrays]]
git-tree-sha1 = "c2a145a145dc03a7620af1444e0264ef907bd44f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "0.5.1"

[[Inflate]]
git-tree-sha1 = "f5fc07d4e706b84f72d54eedcc1c13d92fb0871c"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.2"

[[IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IntervalSets]]
deps = ["Dates", "EllipsisNotation", "Statistics"]
git-tree-sha1 = "3cc368af3f110a767ac786560045dceddfc16758"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.5.3"

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["DocStringExtensions", "LinearAlgebra"]
git-tree-sha1 = "7bd5f6565d80b6bf753738d2bc40a5dfea072070"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.2.5"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "c253236b0ed414624b083e6b72bfe891fbd2c7af"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2021.1.1+1"

[[MappedArrays]]
git-tree-sha1 = "e8b359ef06ec72e8c030463fe02efe5527ee5142"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.1"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "b34e3bc3ca7c94914418637cb10cc4d1d80d877d"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.3"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NaNMath]]
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

[[Netpbm]]
deps = ["FileIO", "ImageCore"]
git-tree-sha1 = "18efc06f6ec36a8b801b23f076e3c6ac7c3bf153"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.0.2"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "c0f4a4836e5f3e0763243b8324200af6d0e0f90c"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.5"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "520e28d4026d16dcf7b8c8140a3041f0e20a9ca8"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.7"

[[PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "59925f4ae6861cddc2313a47514b93b6740f9b6f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.9"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "477bf42b4d1496b454c10cce46645bb5b8a0cf2c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.2"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "a7a7e1a88853564e551e4eba8650f8c38df79b37"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.1.1"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "afadeba63d90ff223a6a48d2009434ecee2ec9e8"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.1"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[SpecialFunctions]]
deps = ["ChainRulesCore", "LogExpFunctions", "OpenSpecFun_jll"]
git-tree-sha1 = "508822dca004bf62e210609148511ad03ce8f1d8"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.6.0"

[[StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[Static]]
deps = ["IfElse"]
git-tree-sha1 = "62701892d172a2fa41a1f829f66d2b0db94a9a63"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.3.0"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3240808c6d463ac46f1c1cd7638375cd22abbccb"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.12"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StringDistances]]
deps = ["Distances"]
git-tree-sha1 = "a4c05337dfe6c4963253939d2acbdfa5946e8e31"
uuid = "88034a9c-02f8-509d-84a9-84ec65e18404"
version = "0.10.0"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[TestImages]]
deps = ["AxisArrays", "ColorTypes", "FileIO", "OffsetArrays", "Pkg", "StringDistances"]
git-tree-sha1 = "259804ebdbc5757ee1bee77860fa6070f9d7db62"
uuid = "5e47fb64-e119-507b-a336-dd2b206d9990"
version = "1.6.0"

[[TiffImages]]
deps = ["ColorTypes", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "OffsetArrays", "OrderedCollections", "PkgVersion", "ProgressMeter"]
git-tree-sha1 = "03fb246ac6e6b7cb7abac3b3302447d55b43270e"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.4.1"

[[TiledIteration]]
deps = ["OffsetArrays"]
git-tree-sha1 = "52c5f816857bfb3291c7d25420b1f4aca0a74d18"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─623b9a5d-4228-4e59-94fe-6cb47ebcda4c
# ╟─ca584849-8be4-4580-aa77-f268dafc850f
# ╟─0040c4e3-eeab-4a5f-bcf4-c3caa536a5ed
# ╟─6e0ff96b-528c-4c09-87fb-0d6c9d71439a
# ╟─c5d18b3d-4e9e-452e-ad2b-6ddd88e4a318
# ╟─4460a8cc-31a7-49ba-b523-37f3ab1f15f9
# ╟─f144f087-a87e-4967-99b2-6f42bcd2a75a
# ╟─c5c753fe-a2e5-4ba3-964a-0e84fb9afe38
# ╟─1242c023-ae43-4185-bfec-a613bca1cea1
# ╟─429dea13-e1c8-48e7-9c6a-7fa2d369e32c
# ╟─13bd7a57-aa41-45f8-81b4-caf1694463af
# ╟─b5a5849c-77a9-4ade-ad30-f29eb726d0b5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
