include("genY.jl")

using PyPlot

N = 100000 # nombre de calculs pour notre probabilite

# initialisation de nos constantes
n=10
A = get_matrix_vp_grande(n)
b = rand(n,1)
c = rand(1,n)
d=1
# quel k ?
k = 2
pas = 0.1 # 21 nombres de points de notre fonction  (2/0.1+1)

# on determine nos bornes
h_max = d
A_puissance = eye(n) # optimisation des calculs
for i in 1:k
  h_max += abs((c*A_puissance*b)[1])
  A_puissance *= A
end
#print(h_max)
ymax, ymin = h_max, -h_max # nos bornes de l'histogramme en abcisse
occurence_y_k = zeros(round(Int,2*ymax/pas)+1)
for i in 1:N # debut de notre tirage aléatoire
  u= zeros(k+1)
  for j in 1:k+1
    u[j]= rand_uniform(-1, 1)
  end
  y_k = get_y_k(u,A,b,c,d,k)
  indice_liste = round(Int,(y_k-ymin)/pas+1) # pour trouver l'indice qui convient
  occurence_y_k[indice_liste] +=1

end
occurence_y_k = occurence_y_k / N
l=collect(ymin:pas:ymax)
l=collect(ymin:pas:ymax)
plot(l,occurence_y_k)
println("Done")
