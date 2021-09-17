### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 02877e92-f596-11eb-10e1-4bd1ab810a56
using PlutoUI, Plots,SpecialFunctions,Luxor,LaTeXStrings

# ╔═╡ 0e7088f6-ee50-48f1-b98d-9cbe8993a7be
md"""
!!! header ""
    Este notebook es parte de una colección de apuntes para el curso **IEE3702 Procesamiento Avanzado de Señales**, [Departamento de Ingeniería Eléctrica](https://www.ing.uc.cl/electrica/), [Pontificia Universidad Católica de Chile](https://www.uc.cl). **Profesor: Rodrigo F. Cádiz** - Consultas y comentarios: [rcadiz@ing.puc.cl](mailto://rcadiz@ing.puc.cl)
"""

# ╔═╡ 61f82a11-7141-40eb-a89e-29744ef21ebb
md"""
[[Volver a la tabla de contenidos](Contenidos.jl.html)]
"""

# ╔═╡ 0e3e0d60-f58e-11eb-065c-e742cd8669c8
md"""
# Señales discretas en $\mathbb{Z}^2$
"""

# ╔═╡ 6aea8d79-7a10-4a27-a065-0008bb571499
md"""

## Definición

Una secuencia o señal 2D discreta $f[m,n]$ se define mediante una función en $\mathbb{Z}^2$:

!!! note "Definición"
	$f[m,n], \,\, -\infty \leq m,n \in \mathbb{Z}$

donde $m, n$ se denominan variables independientes, o dimensiones, y donde usualmente $f:\mathbb{Z}^2\rightarrow\mathbb{R}$, o más generalmente $f:\mathbb{Z}^2\rightarrow\mathbb{C}$. 
"""

# ╔═╡ af0499fc-edf6-4f2d-ba97-d31a3d7ce755
md"""
## Señales de energía y de potencia

La energía $E_f$ de una señal $f[m,n]$ puede definirse mediante la expresión

!!! note "Definición"
	$$E_f = \sum_{k=-\infty}^{\infty} \sum_{l=-\infty}^{\infty} |f[k,l]|^{2}$$

Si esta integral converge, lo que implica que la energía es finita, entonces la señal se considera una **señal de energía**.

Si la energía es infinita, pero la potencia promedio, definida como

!!! note "Definición"
	$$P_f = \lim_{N \rightarrow \infty} \frac{1}{N^2} \sum_{k=-N/2}^{N/2} \sum_{l=-N/2}^{N/2} |f[k,l]|^{2}$$

es finita, entonces, la señal se denomina una **señal de potencia**.
 


"""

# ╔═╡ 0acc6b0f-a16a-40c4-b91c-8ff59c2dea41
md"""
## Representación

Una señal discreta o secuencia bi-dimensional $f[m,n]$ puede ser representada de diversas maneras, por ejemplo como un gráfico tri-dimensional de tallos (stems):
"""

# ╔═╡ cbd7bdca-25ec-4ebb-8569-e7e29445822d
begin
	plotly(size=(600,600),legend=false)
	ms = collect(-5:1:5)
	ns = collect(-5:1:5)
	m_grid = [x for x = ms for y = ns]
	n_grid = [y for x = ms for y = ns]

	cos2D(m,n) = cos((2/20)*pi*m)*cos((2/20)*pi*n)
	
	plot(m_grid, n_grid, [cos2D.(m_grid,n_grid)], st = :scatter3d, mode=:lines,extra_plot_kwargs = KW(:include_mathjax => "cdn"),xlabel = "m", ylabel = "n", markersize=3,camera=(35,35),c=:orange,title="f[m,n]")
	plot!(m_grid, n_grid, [cos2D.(m_grid,n_grid)], st = :stem,linewidth=4,camera=(35,35),c=:darkred)
end

# ╔═╡ c45cf981-d18d-4ecd-81d3-6a23d6d83895
md"""
o como una imagen digital, donde el gráfico se mira desde arriba en coordenadas cartesianas. En este caso la intensidad del color (verde en este caso, pero por lo general se utiliza el gris) es proporcional al valor de la señal 2D en cada uno de los píxeles. Cada píxel corresponde a una coordenada específica en el eje cartesiano.
"""

# ╔═╡ ed5188ef-378d-4b98-a8b5-afa6b4f25d52
begin
	gr(size=(400,400),legend=false)
	img = cos2D.(ms,ns')
	heatmap(img,c=:greens, axis=nothing,xlabel="n",ylabel="m")
end

# ╔═╡ b144f013-5022-44d2-98b5-95d7de378995
md"""
### Imágenes

Tal como observamos arriba, un caso muy relevante de señales en $\mathbb{Z}^2$ son las imágenes digitales, donde cada par de coordenadas $(m,n) \in \mathbb{Z}^2$ indica un píxel. Es además muy común en imágenes utilizar el pixel de arriba a la izquierda como el origen, tal como lo muestra la figura, donde se ve una imagen de $4\times 4$, y el origen $f[0,0]$ se muestra en color celeste. 

Dado que es costumbre indexar los píxeles de una imagen primero por fila y luego por columna, y además comenzar los índices en $0$, entonces en esta convención la dimensión espacial discreta $m$ es vertical y la dimension $n$ es horizontal. Por ejemplo $f[1,3]$ indica el píxel de la segunda fila y cuarta columna de la imagen $f$, indicado en color naranja.


"""

# ╔═╡ 4de89085-6b86-47b8-8084-5268600e84cd
begin
	Drawing(400,300)
	p1 = Point(50,50)
	p2 = Point(250,250)

	fontsize(25)
	sethue("black")
	
	sethue("lightblue")
	Luxor.box(Point(50,50),Point(100,100),:fill)
	sethue("orange")
	Luxor.box(Point(200,100),Point(250,150),:fill)
		
	sethue("black")
	Luxor.box(p1,p2,:stroke)	
	Luxor.line(Point(100,50),Point(100,250),:stroke)
	Luxor.line(Point(150,50),Point(150,250),:stroke)
	Luxor.line(Point(200,50),Point(200,250),:stroke)
	
	Luxor.line(Point(50,100),Point(250,100),:stroke)
	Luxor.line(Point(50,150),Point(250,150),:stroke)
	Luxor.line(Point(50,200),Point(250,200),:stroke)

	Luxor.text("m",Point(5,150))	
	Luxor.arrow(Point(30,50),Point(30,250))
	
	Luxor.text("n",Point(140,20))
	Luxor.arrow(Point(50,30),Point(250,30))	
	
	fontsize(12)
	Luxor.text("f[0,0]",Point(60,80))
	Luxor.text("f[1,3]",Point(210,130))
	
	finish()
	preview()
end


# ╔═╡ 1223d86f-8b5f-438c-93d4-11790111779d
md"""
Por supuesto, es siempre posible adoptar otra convención, lo importante es tener claro como acceder al valor de un píxel en particular en la posición correcta.
"""


# ╔═╡ 95f8a4a8-eb7d-4566-b242-e263fd41d9a1
md"""

## Señales separables

Una señal bi-dimensional $f[m,n]$ es separable, en coordenadas cartesianas, si es que existen dos señales continuas uni-dimensionales $f_1$ y $f_2$ tal que, 
> $f[m,n] = f_1[m]f_2[n], \quad m,n \in \mathbb{Z}$

También a veces es útil la separabilidad aditiva:

!!! note "Definición"
	$f[m,n] = f_1[m] + f_2[n], \quad m,n \in \mathbb{Z}$

"""

# ╔═╡ d82ab8ab-9e85-49d0-a0ce-daf6a8552ecd
md"""
!!! warning ""
	La operación sobre señales separables es mucho más simple que para el caso general de señales no-separables y nos permite realizar operaciones como la convolución y la Transformada de Fourier de forma simplificada.
"""

# ╔═╡ 709fd3aa-8308-41c4-80af-3e9b81b7c9e8
md"""
***
"""

# ╔═╡ b67bef30-f593-11eb-3b23-8d1297e53aa1
md"""
## Señales 2D periódicas

Una señal $f[m,n]$ es períodica de período $(M,N)$ si es que se cumplen las igualdades

!!! note "Definición"
	$f[m,n] = f[m+M,n] = f[m,n+N]$

Un ejemplo de una señal 2D periódica es la siguiente:

"""

# ╔═╡ 49635046-6e65-4e23-9a9f-ec285cbcb038
begin
	gr(size=(800,400), legend=false)
	per(m,n) = cos((15/32)*pi*m)*cos((15/32)*pi*n)
	imgper = per.(ms,ns')

	pper1 = plot(m_grid, n_grid, [per.(m_grid,n_grid)], st =:scatter3d,extra_plot_kwargs = KW(:include_mathjax => "cdn"),xlabel = "m", ylabel = "n", markersize=6,camera=(55,75),c=:orange,zlim=(0,1.2),title="f[m,n]",zticks=[0,1])
	plot!(pper1,m_grid, n_grid, [per.(m_grid,n_grid)], st = :stem,linewidth=4,camera=(55,75),c=:darkred,zlim=(0,1.2),xlabel="m", ylabel="n",zticks=[0,1])
	pper3 = (heatmap(imgper, c=:greys, axis=nothing, xlabel="n", ylabel="m",title="f[m,n]"))
	plot!(pper1,plot(pper3),layout=(1,2))	
end

# ╔═╡ ef866717-7814-4ac6-8551-ac2aba0bb7a3
md"""
## Simetrías

Una señal $f[m,n]$ puede exhibir simetrías del tipo
- **Par**, si $f[-m,-n] = f[m,n] \quad \forall m,n \in \mathbb{Z}$
- **Impar**, si $f[-m,-n] = -f[m,n] \quad \forall m,n \in \mathbb{Z}$
- **Hermitiana**, si $f[-m,-n] = f^{\ast}[m,n] \quad \forall m,n \in \mathbb{Z}$

"""

# ╔═╡ 7645d707-02d9-4171-a296-1f71c715f170
md"""
## Señales importantes
"""

# ╔═╡ bbf31fcb-5b6c-4923-8dd7-3c91bccb0290
md"""
### Impulso

El impulso en el caso discreto se define simplemente como

!!! note "Definición"
	$$\delta[m,n] = \begin{cases}1 & (m,n) = (0,0) \\ 0 & (m,n) \neq (0,0) \end{cases}$$

Esta secuencia es muy importante porque permite descomponer una secuencia arbitraria como una suma infinita de impulsos desplazados

!!! note ""
	$$f[m,n] = \sum_{k \in \mathbb{Z}}\sum_{l \in \mathbb{Z}} f[k,l]\delta[m-k,n-l]$$

"""

# ╔═╡ a6fe5d61-ea14-4eff-b5d6-31cd711cea9f
md"""
### Impulso de línea

El impulso de línea se define como una serie de impulsos sobre una línea. Por ejemplo, si escogemos una línea de 45 grados:

!!! note "Definición"
	$$\delta[m-n] = \begin{cases}1 & m=n \\ 0 & m \neq n \end{cases}$$


"""

# ╔═╡ c190c942-f591-11eb-0375-d9e4b0f184f3
md"""
### Rect

Podemos definir la señal rect bi-dimensional como

!!! note "Definición"
	$\sqcap[m,n] = \sqcap[m]\sqcap[n]$

"""

# ╔═╡ 338a9f04-413e-40a1-87b5-ecf6b6b4a62a
begin
    slider_rot_rect = @bind s1rect Slider(0:90, default=45, show_value=true)
    slider_tilt_rect = @bind s2rect Slider(0:90, default=45, show_value=true)
    md"""
    Rotación = $(slider_rot_rect)
    Elevación = $(slider_tilt_rect)
    """
end

# ╔═╡ f568472c-f596-11eb-27f7-4f19aa152e4e
begin
	gr(size=(800,400), legend=false)
	rect(x) = abs(x) < 0.5 ? 1 : 0 
	rect2D(x,y) = rect(x)*rect(y)
	prect1 = surface(-1:0.10:1, -1:0.10:1, rect2D, c=:inferno, legend=:none,
  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera = (s1rect, s2rect), xlabel="x",ylabel="y")
	prect2 = heatmap(-1:0.1:1, -1:0.1:1, rect2D, c=:grays, axis=nothing,xlabel="x",ylabel="y")
	plot!(prect1, prect2, layout=(1,2))	
end

# ╔═╡ cba41a15-56ec-4166-8e44-d1609389aa47
md"""
### Escalón

Podemos definir la función escalón bi-dimensional como

!!! note "Definición"
	$\vcenter{{\large \ulcorner}}[m,n] = \vcenter{{\large \ulcorner}}[m]\vcenter{{\large \ulcorner}}[n]$

"""

# ╔═╡ 5f380ef2-eddb-43a0-b91c-1a3465bf41e6
begin
    slider_rot_step = @bind s1step Slider(0:90, default=45, show_value=true)
    slider_tilt_step = @bind s2step Slider(0:90, default=45, show_value=true)
    md"""
    Rotación = $(slider_rot_step)
    Elevación = $(slider_tilt_step)
    """
end

# ╔═╡ 70cbcfee-f34e-44d2-9c8c-0dcb0b107e5e
begin
	gr(size=(800,400), legend=false)
	step(x) = x > 0 ? 1 : 0 
	step2D(x,y) = step(x)*step(y)
	pstep1 = surface(-1:0.10:1, -1:0.10:1, step2D, c=:inferno, legend=:none,
  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera = (s1step, s2step), xlabel="x",ylabel="y")
	pstep2 = heatmap(-1:0.1:1, -1:0.1:1, step2D, c=:grays, axis=nothing,xlabel="x",ylabel="y")
	plot!(pstep1, pstep2, layout=(1,2))	
end

# ╔═╡ 8765a118-8802-4633-a6cc-04cafaf6e7be
begin
	plotly(size=(600,600))
	xs = collect(-5:1:5)
	as = collect(-5:1:5)
	x_grid = [x for x = xs for y = as]
	a_grid = [y for x = xs for y = as]

	rect33(x) = begin
		abs(x) < 3 ? 1 : 0
	end
	rect2D33(x,y) = begin
		rect33(x)*rect33(y)
	end
	
	plot(x_grid, a_grid, [rect2D33.(x_grid,a_grid)], st = :scatter3d, mode=:lines,extra_plot_kwargs = KW(:include_mathjax => "cdn"),xlabel = "m", ylabel = "n", markersize=3,camera=(35,35),c=:orange,zlim=(0,1.2),title="f[m,n]",zticks=[0,0.5,1])
	plot!(x_grid, a_grid, [rect2D33.(x_grid,a_grid)], st = :stem,linewidth=4,camera=(35,35),c=:darkred,zlim=(0,1.2))
end


# ╔═╡ 1687f5d2-9bb3-4062-97f7-797d95179811
md"""
### Gauss

Definimos la función gaussiana o gauss bi-dimensional como


!!! note "Definición"
	$\text{Gauss}[m,n] = \text{Gauss}[m]\text{Gauss}[n] = e^{-\pi m^2}e^{-\pi n^2}$


"""

# ╔═╡ b18ed013-8b64-4040-be2f-3edbcfdddb1f
begin
    slider_rot_gauss = @bind s1gauss Slider(0:90, default=45, show_value=true)
    slider_tilt_gauss = @bind s2gauss Slider(0:90, default=45, show_value=true)
    md"""
    Rotación = $(slider_rot_gauss)
    Elevación = $(slider_tilt_gauss)
    """
end

# ╔═╡ c945b30a-be24-43af-9b35-909acdb35f99
begin
	gr(size=(800,400), legend=false)
	gauss(x,y) = exp(-pi*x^2)exp(-pi*y^2)
	pgauss1 = surface(-2:0.01:2, -2:0.01:2, gauss, c=:inferno, legend=:none,
  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera = (s1gauss, s2gauss), xlabel="x",ylabel="y")
	pgauss2 = heatmap(-2:0.01:2, -2:0.01:2, gauss, c=:grays, axis=nothing,xlabel="x",ylabel="y")
	plot!(pgauss1, pgauss2, layout=(1,2))	
end

# ╔═╡ b66a3661-ca42-4dcc-ab9a-9437bafb06e0
md"""
### Sinusoide

Una sinusoide (en este caso un coseno) bi-dimensional de frecuencias espaciales $k,l$ podría escribirse como

> $f[m,n] = \cos[2\pi(km+ln)]$


"""

# ╔═╡ a8d40ad0-f4e0-468d-9fec-ad665cf2e4a2
begin
    slider_u_sin = @bind usin Slider(0:5, default=2, show_value=true)
    slider_v_sin = @bind vsin Slider(0:5, default=4, show_value=true)
    md"""
    Frecuencia en x (u) = $(slider_u_sin)
    Frecuencia en y (v) = $(slider_v_sin)
    """
end

# ╔═╡ f18257f1-cec2-4d69-9f18-3da74b54c983
begin
	gr(size=(800,400), legend=false)
	sinusoid(x,y) = cos(2*pi*(usin*x+vsin*y))
	psin1 = surface(-2:0.05:2, -2:0.05:2, sinusoid, c=:inferno, legend=:none,
  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, xlabel="x",ylabel="y")
	psin2 = heatmap(-2:0.05:2, -2:0.05:2, sinusoid, c=:grays, axis=nothing,xlabel="x",ylabel="y")
	plot!(psin1, psin2, layout=(1,2))	
end

# ╔═╡ 3b6afd35-e08b-4a20-8d7c-5cfe251d6d98
md"""
### Exponencial compleja

Definimos una exponencial compleja bi-dimensional $f:\mathbb{Z}^2\rightarrow\mathbb{C}$, de frecuencias espaciales $k,l$ como

!!! note "Definición"
	$f[m,n] = e^{i 2\pi km}e^{i 2\pi ln} = e^{i 2\pi(km+ln)}$


"""

# ╔═╡ 6fc8995d-b47f-4cac-bf8f-0adbdfa3eb1e
begin
    slider_u_expc = @bind uexpc Slider(0:5, default=2, show_value=true)
    slider_v_expc = @bind vexpc Slider(0:5, default=4, show_value=true)
    md"""
    Frecuencia en x (u) = $(slider_u_expc)
    Frecuencia en y (v) = $(slider_v_expc)
    """
end

# ╔═╡ 8b59d1a0-c45b-4c62-882f-85f504fe604a
begin
	gr(size=(800,800), legend=false)
	realexpc(x,y) = real(exp(2im*pi*(uexpc*x+vexpc*y)))
	imagexpc(x,y) = imag(exp(2im*pi*(uexpc*x+vexpc*y)))
	pexpc1 = surface(-2:0.1:2, -2:0.1:2, realexpc, c=:inferno, legend=:none,
  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, xlabel="x",ylabel="y",title="Parte Real")
	pexpc2 = heatmap(-2:0.1:2, -2:0.1:2, realexpc, c=:grays, axis=nothing,title="Parte Real",xlabel="x",ylabel="y")
	pexpc3 = surface(-2:0.1:2, -2:0.1:2, imagexpc, c=:inferno, legend=:none,
  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, xlabel="x",ylabel="y",title="Parte Imaginaria")
	pexpc4 = heatmap(-2:0.1:2, -2:0.1:2, imagexpc, c=:grays, axis=nothing,title="Parte Imaginaria",xlabel="x",ylabel="y")
	plot!(pexpc1, pexpc2, pexpc3, pexpc4, layout=(2,2))	
end

# ╔═╡ 67f52fd0-f592-11eb-297b-f1e949893a10
md"""
### Sinc

Podemos definir la función sinc bi-dimensional como

!!! note "Definición"
	$\text{sinc}[m,n] = \text{sinc}[m]\text{sinc}[n] = \frac{\sin(\pi m)}{\pi m}\frac{\sin(\pi n)}{\pi n}$

"""

# ╔═╡ ad48e717-587d-4906-8058-5eb7eefcf419
begin
    slider_rot_sinc = @bind s1sinc Slider(0:90, default=45, show_value=true)
    slider_tilt_sinc = @bind s2sinc Slider(0:90, default=45, show_value=true)
    md"""
    Rotación = $(slider_rot_sinc)
    Elevación = $(slider_tilt_sinc)
    """
end

# ╔═╡ b9f5022b-3771-4476-91c2-a283c0c451da
md"""
***
[[Volver a la tabla de contenidos](Contenidos.jl.html)]
"""

# ╔═╡ 50e2fc83-d865-42c1-a534-77f6b1bbc856
md"""
!!! footer ""
	Estos apuntes están licenciados bajo la licencia [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/). **Como citar: Rodrigo F. Cádiz, Procesamiento Avanzado de Señales, 2021.**
"""

# ╔═╡ dd6e49d4-7246-45cc-b4e5-c7d2733d45e5
PlutoUI.TableOfContents(title="Indice", indent=true, depth=4, aside=true)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Luxor = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[compat]
LaTeXStrings = "~1.2.1"
Luxor = "~2.15.0"
Plots = "~1.20.0"
PlutoUI = "~0.7.9"
SpecialFunctions = "~1.6.0"
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

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c3598e525718abcc440f69cc6d5f60dda0a1b61e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.6+5"

[[Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "d0b3f8b4ad16cb0a2988c6788646a5e6a17b6b1b"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.0.5"

[[Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "e2f47f6d8337369411569fd45ae5753ca10394c6"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.0+6"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "bdc0937269321858ab2a4f288486cb258b9a0af7"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.3.0"

[[ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random", "StaticArrays"]
git-tree-sha1 = "ed268efe58512df8c7e224d2e170afd76dd6a417"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.13.0"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "a66a8e024807c4b3d186eb1cab2aff3505271f8e"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.6"

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

[[Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4437b64df1e0adccc3e5d1adbc3ac741095e4677"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.9"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

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

[[EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "92d8f9f208637e8d2d28c664051a00569c01493d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.1.5+1"

[[Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b3bfd02e98aedfa5cf885665493c5598c350cd2f"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.2.10+0"

[[FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "LibVPX_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3cc57ad0a213808473eafef4845a74766242e05f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.3.1+4"

[[FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "3c041d2ac0a52a12a27af2782b34900d9c3ee68c"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.11.1"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "35895cf184ceaab11fd778b4590144034a167a2f"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.1+14"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "cbd58c9deb1d304f5a245a0b7eb841a2560cfec6"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.1+5"

[[FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "dba1e8614e98949abfa60480b13653813d8f0157"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.5+0"

[[GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "182da592436e287758ded5be6e32c406de3a2e47"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.58.1"

[[GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "d59e8320c2747553788e4fc42231489cc602fa50"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.58.1+0"

[[GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "58bcdf5ebc057b085e58d95c138725628dd7453c"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.1"

[[Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "7bf67e9a481712b3dbe9cb3dac852dc4b1162e02"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+0"

[[Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "2c1cf4df419938ece72de17f368a021ee162762e"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.0"

[[Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "44e3b40da000eab4ccb1aecdc4801c040026aeb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.13"

[[HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "8a954fed8ac097d5be04921d595f741115c1b2ad"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+0"

[[ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "595155739d361589b3d074386f77c107a8ada6f7"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.2"

[[ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils", "Libdl", "Pkg", "Random"]
git-tree-sha1 = "5bc1cb62e0c5f1005868358db0692c994c3a13c6"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.2.1"

[[ImageMagick_jll]]
deps = ["JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1c0a2295cca535fabaf2029062912591e9b61987"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.10-12+3"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d735490ac75c5cb9f1b00d8b5509c11984dc6943"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.0+0"

[[Juno]]
deps = ["Base64", "Logging", "Media", "Profile"]
git-tree-sha1 = "07cb43290a840908a771552911a6274bc6c072c7"
uuid = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
version = "0.8.4"

[[LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[LaTeXStrings]]
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

[[Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a4b12a1bd2ebade87891ab7e36fdbce582301a92"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.6"

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

[[LibVPX_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "12ee7e23fa4d18361e7c2cde8f8337d4c3101bc7"
uuid = "dd192d2f-8180-539f-9fb4-cc70b1dcf69a"
version = "1.10.0+0"

[[Libcroco_jll]]
deps = ["Artifacts", "Glib_jll", "JLLWrappers", "Libdl", "Pkg", "XML2_jll"]
git-tree-sha1 = "a8e3b1b67458c8933992b95db9c4b37865906e3f"
uuid = "57eb2189-7eb1-52c8-ac0e-99495f550b14"
version = "0.6.13+2"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "761a393aeccd6aa92ec3515e428c26bf99575b3b"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+0"

[[Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[Librsvg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libcroco_jll", "Libdl", "Pango_jll", "Pkg", "gdk_pixbuf_jll"]
git-tree-sha1 = "af3e6dc6747e53a0236fbad80b37e3269cf66a9f"
uuid = "925c91fb-5dd6-59dd-8e8c-345e74382d89"
version = "2.42.2+3"

[[Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "340e257aada13f95f98ee352d316c3bed37c8ab9"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+0"

[[Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

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

[[Luxor]]
deps = ["Base64", "Cairo", "Colors", "Dates", "FFMPEG", "FileIO", "ImageMagick", "Juno", "QuartzImageIO", "Random", "Rsvg"]
git-tree-sha1 = "b2b3d49ffb3b89d9e052da47a0b6df13579738ea"
uuid = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
version = "2.15.0"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "0fb723cd8c45858c22169b2e42269e53271a6df7"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.7"

[[MappedArrays]]
git-tree-sha1 = "e8b359ef06ec72e8c030463fe02efe5527ee5142"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.1"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[Media]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "75a54abd10709c01f1b86b84ec225d26e840ed58"
uuid = "e89f7d12-3494-54d1-8411-f7d8b9ae1f27"
version = "0.5.0"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "4ea90bd5d3985ae1f9a908bd4500ae88921c5ce7"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.0"

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

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "c870a0d713b51e4b49be6432eff0e26a4325afee"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.6"

[[Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7937eda4681660b4d6aeeecc2f7e1c81c8ee4e2f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+0"

[[OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "15003dcb7d8db3c6c857fda14891a539a8f2705a"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.10+0"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "646eed6f6a5d8df6708f15ea7e02a7a2c4fe4800"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.10"

[[Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9a336dee51d20d1ed890c4a8dca636e86e2b76ca"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.42.4+10"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "bfd7d8c7fd87f04543810d9cbd3995972236ba1b"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.2"

[[Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "501c20a63a34ac1d015d5304da0e645f42d91c9f"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.0.11"

[[Plots]]
deps = ["Base64", "Contour", "Dates", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs"]
git-tree-sha1 = "e39bea10478c6aff5495ab522517fae5134b40e3"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.20.0"

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

[[Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "ad368663a5e20dbb8d6dc2fddeefe4dae0781ae8"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+0"

[[QuartzImageIO]]
deps = ["FileIO", "ImageCore", "Libdl"]
git-tree-sha1 = "16de3b880ffdfbc8fc6707383c00a2e076bb0221"
uuid = "dca85d43-d64c-5e67-8c65-017450d5d020"
version = "0.7.4"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[RecipesBase]]
git-tree-sha1 = "b3fb709f3c97bfc6e948be68beeecb55a0b340ae"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.1"

[[RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "2a7a2469ed5d94a98dea0e85c46fa653d76be0cd"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.3.4"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[Rsvg]]
deps = ["Cairo", "Glib_jll", "Librsvg_jll"]
git-tree-sha1 = "3d3dc66eb46568fb3a5259034bfc752a0eb0c686"
uuid = "c4c386cf-5103-5370-be45-f3a111cca3b8"
version = "1.0.0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

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

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3fedeffc02e47d6e3eb479150c8e5cd8f15a77a0"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.10"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "fed1ec1e65749c4d96fc20dd13bea72b55457e62"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.9"

[[StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "000e168f5cc9aded17b6999a560b7c11dda69095"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.0"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "d0c690d37c73aeb5ca063056283fde5585a41710"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.5.0"

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

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll"]
git-tree-sha1 = "2839f1c1296940218e35df0bbb220f2a79686670"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.18.0+4"

[[XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "cc4bf3fdde8b7e3e9fa0351bdeedba1cf3b7f6e6"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.0+0"

[[gdk_pixbuf_jll]]
deps = ["Artifacts", "Glib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Xorg_libX11_jll", "libpng_jll"]
git-tree-sha1 = "0facfc4bfd873c21b83a053bbf182b9ef19c69d8"
uuid = "da03df04-f53b-5353-a52f-6a8b0620ced0"
version = "2.42.6+0"

[[libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "acc685bcf777b2202a904cdcb49ad34c2fa1880c"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.14.0+4"

[[libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7a5780a0d9c6864184b3a2eeeb833a0c871f00ab"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "0.1.6+4"

[[libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "c45f4e40e7aafe9d086379e5578947ec8b95a8fb"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d713c1ce4deac133e3334ee12f4adff07f81778f"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2020.7.14+2"

[[x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "487da2f8f2f0c8ee0e83f39d13037d6bbf0a45ab"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.0.0+3"

[[xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─0e7088f6-ee50-48f1-b98d-9cbe8993a7be
# ╟─61f82a11-7141-40eb-a89e-29744ef21ebb
# ╟─0e3e0d60-f58e-11eb-065c-e742cd8669c8
# ╟─6aea8d79-7a10-4a27-a065-0008bb571499
# ╟─af0499fc-edf6-4f2d-ba97-d31a3d7ce755
# ╟─0acc6b0f-a16a-40c4-b91c-8ff59c2dea41
# ╟─cbd7bdca-25ec-4ebb-8569-e7e29445822d
# ╟─c45cf981-d18d-4ecd-81d3-6a23d6d83895
# ╟─ed5188ef-378d-4b98-a8b5-afa6b4f25d52
# ╟─b144f013-5022-44d2-98b5-95d7de378995
# ╟─4de89085-6b86-47b8-8084-5268600e84cd
# ╟─1223d86f-8b5f-438c-93d4-11790111779d
# ╟─95f8a4a8-eb7d-4566-b242-e263fd41d9a1
# ╟─d82ab8ab-9e85-49d0-a0ce-daf6a8552ecd
# ╟─709fd3aa-8308-41c4-80af-3e9b81b7c9e8
# ╟─b67bef30-f593-11eb-3b23-8d1297e53aa1
# ╟─49635046-6e65-4e23-9a9f-ec285cbcb038
# ╟─ef866717-7814-4ac6-8551-ac2aba0bb7a3
# ╟─7645d707-02d9-4171-a296-1f71c715f170
# ╟─bbf31fcb-5b6c-4923-8dd7-3c91bccb0290
# ╟─a6fe5d61-ea14-4eff-b5d6-31cd711cea9f
# ╟─c190c942-f591-11eb-0375-d9e4b0f184f3
# ╟─338a9f04-413e-40a1-87b5-ecf6b6b4a62a
# ╟─f568472c-f596-11eb-27f7-4f19aa152e4e
# ╟─cba41a15-56ec-4166-8e44-d1609389aa47
# ╟─5f380ef2-eddb-43a0-b91c-1a3465bf41e6
# ╟─70cbcfee-f34e-44d2-9c8c-0dcb0b107e5e
# ╠═8765a118-8802-4633-a6cc-04cafaf6e7be
# ╟─1687f5d2-9bb3-4062-97f7-797d95179811
# ╟─b18ed013-8b64-4040-be2f-3edbcfdddb1f
# ╟─c945b30a-be24-43af-9b35-909acdb35f99
# ╟─b66a3661-ca42-4dcc-ab9a-9437bafb06e0
# ╟─a8d40ad0-f4e0-468d-9fec-ad665cf2e4a2
# ╟─f18257f1-cec2-4d69-9f18-3da74b54c983
# ╟─3b6afd35-e08b-4a20-8d7c-5cfe251d6d98
# ╟─6fc8995d-b47f-4cac-bf8f-0adbdfa3eb1e
# ╟─8b59d1a0-c45b-4c62-882f-85f504fe604a
# ╟─67f52fd0-f592-11eb-297b-f1e949893a10
# ╟─ad48e717-587d-4906-8058-5eb7eefcf419
# ╟─b9f5022b-3771-4476-91c2-a283c0c451da
# ╟─50e2fc83-d865-42c1-a534-77f6b1bbc856
# ╟─02877e92-f596-11eb-10e1-4bd1ab810a56
# ╟─dd6e49d4-7246-45cc-b4e5-c7d2733d45e5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
