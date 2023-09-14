--Algebra Relacional--
-1-
PI estudiante.nombre,estudiante.apellido(SIGMA estudiante.genero='F' y departamento.nombre='MACC'(estudiante join departamento))

-2-
PI curso.nombre(SIGMA grupo.periodo=1 y grupo.anio=2021 (curso join grupo))

--SQL--
-1-
select e.nombre, e.apellido
from estudiante e, departamento d
where e.id_departamento=d.id and e.genero ='F' and d.nombre='MACC'

-2-
select distinct c.nombre
from curso c, grupo g
where c.id=g.id_curso and g.periodo=1 and g.anio=2021

-3-
(select  p.nombre, p.apellido
from profesor p, grupo g, curso c
where c.nombre='Ingeniería de datos' and p.id=g.id_profesor and g.id_curso=c.id)
union
(select p.nombre, p.apellido
from profesor p, grupo g, curso c
where c.nombre='Calculo diferencial' and p.id=g.id_profesor and g.id_curso=c.id)

-4-
(select c.nombre, g.nombre as grupo_nom
from curso c, grupo g, horario h
where c.id = g.id_curso and h.id_grupo=g.id and h.dia=1)
intersect
(select c.nombre, g.nombre as grupo_nom
from curso c, grupo g, horario h
where c.id = g.id_curso and h.id_grupo=g.id and h.dia=3)

-5-
select e.nombre, e.apellido, avg(i.calificacion)
from estudiante e, departamento d, inscripcion i
where e.id_departamento=d.id and d.nombre='MACC' and e.codigo=i.codigo_estudiante
group by e.nombre, e.apellido
having avg(i.calificacion)>30
order by e.nombre, e.apellido asc

-6-
select d.nombre, count(e.nombre)
from estudiante e, departamento d
where e.genero='F' and d.id=e.id_departamento
group by d.nombre
