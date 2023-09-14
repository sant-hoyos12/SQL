--1--
select e.codigo, i.calificacion
from estudiante e, inscripcion i
where i.calificacion >40 and e.codigo = i.codigo_estudiante

--2--
select id, nombre
from curso c
where creditos<4

--3--
(select e.nombre, e.apellido, d.nombre as dep_nombre
from estudiante e, departamento d
where e.id_departamento=d.id and d.nombre='Biologia')
union
(select e.nombre, e.apellido, d.nombre as dep_nombre
from estudiante e, departamento d
where e.id_departamento=d.id and d.nombre='Economia')

--4--
select avg(c.creditos)
from curso c, departamento d
where c.id_departamento = d.id and d.nombre='MACC'

--5--
(select e.codigo, e.nombre, e.apellido
from estudiante e, departamento d, curso c, inscripcion i, grupo g
where d.nombre = 'MACC' and g.anio=2020 and g.periodo =1 and e.codigo = i.codigo_estudiante
and i.id_grupo = g.id and g.id_curso=c.id and c.id_departamento = d.idand e.id_departamento=d.id  )
union
(select e.codigo, e.nombre,e.apellido
from estudiante e, departamento d, curso c, inscripcion i, grupo g
where d.nombre = 'MACC' and g.anio=2019 and g.periodo =2 and e.codigo = i.codigo_estudiante
and i.id_grupo = g.id and g.id_curso=c.id and e.id_departamento=d.id)

--6--
select count(distinct e.nombre)
from departamento d, estudiante e, inscripcion i, grupo g, curso c
where d.nombre = 'MACC' and e.genero = 'F' and e.codigo = i.codigo_estudiante
and i.id_grupo = g.id and g.id_curso=c.id and c.id_departamento = d.id



