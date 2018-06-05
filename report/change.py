f = open('access.tex', 'r').read().split('\n')
for i, l in enumerate(f):
    #print(l)
    if '\Figure' in l:
        # "\Figure[ht!][scale=0.5]{pendulo.PNG}{Representación gráfica del péndulo invertido.\label{diagram}}"
        ty, sc, *an = l.split("\Figure")[1].split("]")
        ty = ty[1:]
        sc = sc[1:]
        an = "]".join(an)
        im, la = an.split("}{")
        im = im[1:]
        la = la[:-1]
        new = """\\begin{figure}[%s]
\\caption{%s}
  \\centering
\\includegraphics[%s]{%s}
\\end{figure}""" % (ty, la, sc, im)
        f[i] = new


g = open('main.tex', 'w')
g.write("\n".join(f))
