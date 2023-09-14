--1a--

select e.apellido, f.nombre
from estudiante e, departamento d, facultad f
where e.id_departamento=d.id and d.id_facultad = f.id and f.nombre='Ciencias Naturales'
order by e.apellido


--1b--
select p.nombre, c.nombre, g.anio, g.periodo
from profesor p, curso c, grupo g
where p.id = g.id_profesor and c.id = g.id_curso and c.nombre= 'Ingeniería de Datos' and g.anio = 2021 and g.periodo = 1
order by p.nombre


--1c--
select e.nombre, e.fecha_nacimiento, c.nombre
from estudiante e, curso c, inscripcion i, grupo g
where e.codigo = i.codigo_estudiante and i.id_grupo = g.id and g.id_curso = c.id and e.genero='F' and c.nombre= 'Ingeniería de Datos' 
order by e.fecha_nacimiento

--1d--

select e.nombre, e.apellido, e.fecha_nacimiento, c.nombre
from estudiante e, curso c, inscripcion i, grupo g
where e.codigo = i.codigo_estudiante and i.id_grupo = g.id and g.id_curso = c.id 
and e.fecha_nacimiento > make_date(cast(Extract(year from current_date)-20 as integer),
									cast(Extract(month from current_date) as integer), 
									cast(Extract(day from current_date) as integer))
and c.nombre= 'Ingeniería de Datos' 
order by e.fecha_nacimiento


--1e--
select e.nombre, i.calificacion,c.nombre, g.anio, g.periodo 
from estudiante e, inscripcion i, curso c, grupo g
where e.codigo = i.codigo_estudiante and i.id_grupo = g.id and g.id_curso = c.id and i.calificacion<30 and c.nombre= 'Ingeniería de Datos' and g.anio = 2021 and g.periodo = 1


--1f--
select distinct e.nombre, d.nombre, h.dia
from departamento d, estudiante e, horario h, inscripcion i, curso c, grupo g
where d.nombre = 'MACC' and h.dia = 3 and d.id = e.id_departamento and e.codigo = i.codigo_estudiante and i.id_grupo = g.id and g.id_curso = c.id and
g.id = h.id_grupo


--1g--
(select p.nombre, p.apellido
from profesor p)
except(select p.nombre, p.apellido
	   from profesor p, grupo g
	   where p.id = g.id_profesor and g.anio = 2021 and g.periodo = 1)

--1h--
select e.nombre, c.nombre
from edificio e, curso c, grupo g, horario h, salon s
where g.id_curso = c.id and g.id = h.id_grupo and h.id_salon = s.id and s.id_edificio =e.id and e.nombre = 'Casur'

--1i--
select round(avg(i.calificacion),2)
from curso c, inscripcion i, grupo g
where i.id_grupo = g.id and g.id_curso = c.id and c.nombre= 'Ingeniería de Datos' and g.anio = 2021 and g.periodo = 1

--1j--
select p.nombre, p.apellido, count(c.nombre)
from profesor p, curso c, grupo g
where p.id = g.id_profesor and c.id = g.id_curso and g.anio = 2020 and g.periodo = 2
group by p.nombre, p.apellido
order by p.apellido


--2--

